#define SQLITE_CONFIG_SINGLETHREAD         1  /* nil */
#define SQLITE_CONFIG_MULTITHREAD          2  /* nil */
#define SQLITE_CONFIG_SERIALIZED           3  /* nil */
#define SQLITE_CONFIG_MALLOC               4  /* sqlite3_mem_methods* */
#define SQLITE_CONFIG_GETMALLOC            5  /* sqlite3_mem_methods* */
#define SQLITE_CONFIG_SCRATCH              6  /* No longer used */
#define SQLITE_CONFIG_PAGECACHE            7  /* void*, int sz, int N */
#define SQLITE_CONFIG_HEAP                 8  /* void*, int nByte, int min */
#define SQLITE_CONFIG_MEMSTATUS            9  /* boolean */
#define SQLITE_CONFIG_MUTEX               10  /* sqlite3_mutex_methods* */
#define SQLITE_CONFIG_GETMUTEX            11  /* sqlite3_mutex_methods* */
/* previously SQLITE_CONFIG_CHUNKALLOC    12 which is now unused. */
#define SQLITE_CONFIG_LOOKASIDE           13  /* int int */
#define SQLITE_CONFIG_PCACHE              14  /* no-op */
#define SQLITE_CONFIG_GETPCACHE           15  /* no-op */
#define SQLITE_CONFIG_LOG                 16  /* xFunc, void* */
#define SQLITE_CONFIG_URI                 17  /* int */
#define SQLITE_CONFIG_PCACHE2             18  /* sqlite3_pcache_methods2* */
#define SQLITE_CONFIG_GETPCACHE2          19  /* sqlite3_pcache_methods2* */
#define SQLITE_CONFIG_COVERING_INDEX_SCAN 20  /* int */
#define SQLITE_CONFIG_SQLLOG              21  /* xSqllog, void* */
#define SQLITE_CONFIG_MMAP_SIZE           22  /* sqlite3_int64, sqlite3_int64 */
#define SQLITE_CONFIG_WIN32_HEAPSIZE      23  /* int nByte */
#define SQLITE_CONFIG_PCACHE_HDRSZ        24  /* int *psz */
#define SQLITE_CONFIG_PMASZ               25  /* unsigned int szPma */
#define SQLITE_CONFIG_STMTJRNL_SPILL      26  /* int nByte */
#define SQLITE_CONFIG_SMALL_MALLOC        27  /* boolean */
#define SQLITE_CONFIG_SORTERREF_SIZE      28  /* int nByte */
#define SQLITE_CONFIG_MEMDB_MAXSIZE       29  /* sqlite3_int64 */
#define SQLITE_CONFIG_ROWID_IN_VIEW       30  /* int* */