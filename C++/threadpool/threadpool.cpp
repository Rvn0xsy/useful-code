#include "queue.h"
#include "threadpool.h"
/*
#include <iostream>
#include "threadpool/threadpool.h"

int main() {
	BOOL A = TRUE;
	if (!threadpool::Create(threadpool::LOCAL_THREADPOOL, 10)) {
		return EXIT_FAILURE;
	}

	if (!threadpool::Start(threadpool::LOCAL_THREADPOOL)) {
		return EXIT_FAILURE;
	}

	for (size_t i = 0; i < 100; i++)
	{
		threadpool::PutTask(threadpool::LOCAL_THREADPOOL, L"C:\\");
	}

	threadpool::Wait(threadpool::LOCAL_THREADPOOL);
	return EXIT_SUCCESS;


	return 0;
}
*/
typedef struct task_info_ {
	std::wstring Path;
	BOOL Stop;
	TAILQ_ENTRY(task_info_) Entries;

} TASK_INFO, *PTASK_INFO;

typedef TAILQ_HEAD(task_list_, task_info_) TASK_LIST, *PTASK_LIST;

typedef struct threadpool_info {

	PHANDLE hThreads;
	SIZE_T ThreadsCount;
	BOOL IsActive;
	CRITICAL_SECTION CriticalSection;
	TASK_LIST TaskList;

} THREADPOOL_INFO, *PTHREADPOOL_INFO;


static THREADPOOL_INFO g_LocalThreadPool;
static THREADPOOL_INFO g_NetworkThreadPool;
static DWORD BufferSize = 5242880;


DWORD ThreadpoolHandler(__in PTHREADPOOL_INFO ThreadPoolInfo) 
{
	

	while (TRUE) {

		EnterCriticalSection(&ThreadPoolInfo->CriticalSection);


		PTASK_INFO TaskInfo = TAILQ_FIRST(&ThreadPoolInfo->TaskList);
		if (!TaskInfo) {

			LeaveCriticalSection(&ThreadPoolInfo->CriticalSection);
			Sleep(5000);
			continue;

		}

		TAILQ_REMOVE(&ThreadPoolInfo->TaskList, TaskInfo, Entries);

		LeaveCriticalSection(&ThreadPoolInfo->CriticalSection);

		if (TaskInfo->Stop) {
			break;
		}
		std::wcout << L"[+]" << TaskInfo->Path << std::endl;
		Sleep(1000);

		free(TaskInfo);

	}

	ExitThread(EXIT_SUCCESS);
	return EXIT_SUCCESS;
}

VOID threadpool::Initialize()
{
	RtlSecureZeroMemory(&g_LocalThreadPool, sizeof(g_LocalThreadPool));
	g_LocalThreadPool.IsActive = FALSE;
}

BOOL threadpool::Create(
	__in INT ThreadPoolID,
	__in SIZE_T ThreadsCount
	)
{
	PTHREADPOOL_INFO ThreadPoolInfo = NULL;
	if (ThreadPoolID == threadpool::LOCAL_THREADPOOL) {
		ThreadPoolInfo = &g_LocalThreadPool;
	} 
	else if (ThreadPoolID == threadpool::NETWORK_THREADPOOL) {
		ThreadPoolInfo = &g_NetworkThreadPool;
	}
	else {
		return FALSE;
	}

	TAILQ_INIT(&ThreadPoolInfo->TaskList);
	ThreadPoolInfo->ThreadsCount = ThreadsCount;
	ThreadPoolInfo->IsActive = FALSE;
	InitializeCriticalSection(&ThreadPoolInfo->CriticalSection);
	ThreadPoolInfo->hThreads = (PHANDLE)malloc(sizeof(HANDLE) * ThreadsCount);
	if (!ThreadPoolInfo->hThreads) {
		return FALSE;
	}

	return TRUE;
}

BOOL threadpool::Start(__in INT ThreadPoolID)
{
	PTHREADPOOL_INFO ThreadPoolInfo = NULL;
	if (ThreadPoolID == threadpool::LOCAL_THREADPOOL) {
		ThreadPoolInfo = &g_LocalThreadPool;
	}
	else {
		return FALSE;
	}

	ThreadPoolInfo->IsActive = TRUE;

	for (SIZE_T i = 0; i < ThreadPoolInfo->ThreadsCount; i++) {
		ThreadPoolInfo->hThreads[i] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)&ThreadpoolHandler, ThreadPoolInfo, 0, NULL);
	}

	return TRUE;
}

BOOL threadpool::PutTask(
	__in INT ThreadPoolID,
	__in std::wstring Path
	)
{
	PTHREADPOOL_INFO ThreadPoolInfo = NULL;
	if (ThreadPoolID == threadpool::LOCAL_THREADPOOL) {
		ThreadPoolInfo = &g_LocalThreadPool;
	}
	else {
		return FALSE;
	}

	PTASK_INFO Task = new TASK_INFO;
	if (!Task) {
		return FALSE;
	}

	Task->Path = Path;
	Task->Stop = FALSE;

	EnterCriticalSection(&ThreadPoolInfo->CriticalSection);
	TAILQ_INSERT_TAIL(&ThreadPoolInfo->TaskList, Task, Entries);
	LeaveCriticalSection(&ThreadPoolInfo->CriticalSection);
	return TRUE;
}

BOOL 
threadpool::PutFinalTask(
	__in INT ThreadPoolID
	)
{
	PTHREADPOOL_INFO ThreadPoolInfo = NULL;
	if (ThreadPoolID == threadpool::LOCAL_THREADPOOL) {
		ThreadPoolInfo = &g_LocalThreadPool;
	}
	else {
		return FALSE;
	}

	PTASK_INFO Task = new TASK_INFO;
	if (!Task) {
		return FALSE;

	}

	Task->Stop = TRUE;
	EnterCriticalSection(&ThreadPoolInfo->CriticalSection);
	TAILQ_INSERT_TAIL(&ThreadPoolInfo->TaskList, Task, Entries);
	LeaveCriticalSection(&ThreadPoolInfo->CriticalSection);
	return TRUE;
}

BOOL threadpool::IsActive(__in INT ThreadPoolID)
{
	PTHREADPOOL_INFO ThreadPoolInfo = NULL;
	if (ThreadPoolID == threadpool::LOCAL_THREADPOOL) {
		ThreadPoolInfo = &g_LocalThreadPool;
	}
	else {
		return FALSE;
	}

	return ThreadPoolInfo->IsActive;
}

VOID threadpool::Wait(__in INT ThreadPoolID)
{
	PTHREADPOOL_INFO ThreadPoolInfo = NULL;
	if (ThreadPoolID == threadpool::LOCAL_THREADPOOL) {
		ThreadPoolInfo = &g_LocalThreadPool;
	}
	else if (ThreadPoolID == threadpool::NETWORK_THREADPOOL) {
		ThreadPoolInfo = &g_NetworkThreadPool;
	}
	else {
		return;
	}

	for (SIZE_T i = 0; i < ThreadPoolInfo->ThreadsCount; i++) {
		PutFinalTask(ThreadPoolID);
	}

	WaitForMultipleObjects(ThreadPoolInfo->ThreadsCount, ThreadPoolInfo->hThreads, TRUE, INFINITE);
}