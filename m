Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 762247A7109
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 05:37:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr43q31k2z3bZr
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 13:37:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr43h42Xyz2ykV
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 13:37:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsTVI8T_1695181050;
Received: from 30.97.48.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsTVI8T_1695181050)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 11:37:31 +0800
Message-ID: <d0a5e0bc-c1d6-e150-8ce1-d6ca7ed9f2ad@linux.alibaba.com>
Date: Wed, 20 Sep 2023 11:37:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs-utils: lib: introduce diskbuf
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230915152913.4124712-1-hsiangkao@linux.alibaba.com>
 <e7e0f567-9ee6-911c-3f76-a5f6d1c9ba68@linux.alibaba.com>
 <22b77b04-ddf3-3e62-574a-5a6018e9fdc5@linux.alibaba.com>
In-Reply-To: <22b77b04-ddf3-3e62-574a-5a6018e9fdc5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/9/20 11:35, Gao Xiang wrote:
> 
> 
> On 2023/9/20 11:32, Jingbo Xu wrote:
>>
>>
>> On 9/15/23 11:29 PM, Gao Xiang wrote:
>>> Previously, each tar data file will be kept as a temporary file before
>>> landing to the target image since the input stream may be non-seekable.
>>>
>>> It's somewhat ineffective.  Let's introduce a new diskbuf approach to
>>> manage those buffers.  Laterly, each stream can be redirected to blob
>>> files for external reference.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>>   include/erofs/diskbuf.h  |  30 ++++++++
>>>   include/erofs/internal.h |   8 ++-
>>>   lib/Makefile.am          |   3 +-
>>>   lib/diskbuf.c            | 147 +++++++++++++++++++++++++++++++++++++++
>>>   lib/inode.c              |  33 +++++----
>>>   lib/io.c                 |   1 +
>>>   lib/tar.c                |  21 ++++--
>>>   mkfs/main.c              |  10 +++
>>>   8 files changed, 230 insertions(+), 23 deletions(-)
>>>   create mode 100644 include/erofs/diskbuf.h
>>>   create mode 100644 lib/diskbuf.c
>>>
>>> diff --git a/include/erofs/diskbuf.h b/include/erofs/diskbuf.h
>>> new file mode 100644
>>> index 0000000..29d9fe2
>>> --- /dev/null
>>> +++ b/include/erofs/diskbuf.h
>>> @@ -0,0 +1,30 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>>> +#ifndef __EROFS_DISKBUF_H
>>> +#define __EROFS_DISKBUF_H
>>> +
>>> +#ifdef __cplusplus
>>> +extern "C"
>>> +{
>>> +#endif
>>> +
>>> +#include "erofs/defs.h"
>>> +
>>> +struct erofs_diskbuf {
>>> +    void *sp;        /* internal stream pointer */
>>> +    u64 offset;        /* internal offset */
>>> +};
>>> +
>>> +int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *off);
>>> +
>>> +int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off);
>>> +void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64 len);
>>> +void erofs_diskbuf_close(struct erofs_diskbuf *db);
>>> +
>>> +int erofs_diskbuf_init(unsigned int nstrms);
>>> +void erofs_diskbuf_exit(void);
>>> +
>>> +#ifdef __cplusplus
>>> +}
>>> +#endif
>>> +
>>> +#endif
>>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>>> index 19b912b..a3c6fcd 100644
>>> --- a/include/erofs/internal.h
>>> +++ b/include/erofs/internal.h
>>> @@ -107,7 +107,7 @@ struct erofs_sb_info {
>>>       u8 xattr_prefix_count;
>>>       struct erofs_xattr_prefix_item *xattr_prefixes;
>>> -    int devfd;
>>> +    int devfd, devblksz;
>>>       u64 devsz;
>>>       dev_t dev;
>>>       unsigned int nblobs;
>>> @@ -150,6 +150,8 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>>   #define EROFS_I_EA_INITED    (1 << 0)
>>>   #define EROFS_I_Z_INITED    (1 << 1)
>>> +struct erofs_diskbuf;
>>> +
>>>   struct erofs_inode {
>>>       struct list_head i_hash, i_subdirs, i_xattrs;
>>> @@ -189,7 +191,7 @@ struct erofs_inode {
>>>       char *i_srcpath;
>>>       union {
>>>           char *i_link;
>>> -        FILE *i_tmpfile;
>>> +        struct erofs_diskbuf *i_diskbuf;
>>>       };
>>>       unsigned char datalayout;
>>>       unsigned char inode_isize;
>>> @@ -197,7 +199,7 @@ struct erofs_inode {
>>>       unsigned short idata_size;
>>>       bool compressed_idata;
>>>       bool lazy_tailblock;
>>> -    bool with_tmpfile;
>>> +    bool with_diskbuf;
>>>       bool opaque;
>>>       /* OVL: non-merge dir that may contain whiteout entries */
>>>       bool whiteouts;
>>> diff --git a/lib/Makefile.am b/lib/Makefile.am
>>> index 8a45bd6..483d410 100644
>>> --- a/lib/Makefile.am
>>> +++ b/lib/Makefile.am
>>> @@ -9,6 +9,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>>>         $(top_srcdir)/include/erofs/config.h \
>>>         $(top_srcdir)/include/erofs/decompress.h \
>>>         $(top_srcdir)/include/erofs/defs.h \
>>> +      $(top_srcdir)/include/erofs/diskbuf.h \
>>>         $(top_srcdir)/include/erofs/err.h \
>>>         $(top_srcdir)/include/erofs/exclude.h \
>>>         $(top_srcdir)/include/erofs/flex-array.h \
>>> @@ -33,7 +34,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>>>                 namei.c data.c compress.c compressor.c zmap.c decompress.c \
>>>                 compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
>>>                 fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
>>> -              block_list.c xxhash.c rebuild.c
>>> +              block_list.c xxhash.c rebuild.c diskbuf.c
>>>   liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
>>>   if ENABLE_LZ4
>>> diff --git a/lib/diskbuf.c b/lib/diskbuf.c
>>> new file mode 100644
>>> index 0000000..004b1c0
>>> --- /dev/null
>>> +++ b/lib/diskbuf.c
>>> @@ -0,0 +1,147 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>>> +#include "erofs/diskbuf.h"
>>> +#include "erofs/internal.h"
>>> +#include "erofs/print.h"
>>> +#include <stdio.h>
>>> +#include <errno.h>
>>> +#include <sys/stat.h>
>>> +#include <unistd.h>
>>> +#include <stdlib.h>
>>> +
>>> +/* A simple approach to avoid creating too many temporary files */
>>> +static struct erofs_diskbufstrm {
>>> +    u64 count;
>>> +    u64 tailoffset, devpos;
>>> +    int fd;
>>> +    unsigned int alignsize;
>>> +    bool locked;
>>> +} *dbufstrm;
>>> +
>>> +int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
>>> +{
>>> +    const struct erofs_diskbufstrm *strm = db->sp;
>>> +    u64 offset;
>>> +
>>> +    if (!strm)
>>> +        return -1;
>>> +    offset = db->offset + strm->devpos;
>>> +    if (lseek(strm->fd, offset, SEEK_SET) != offset)
>>> +        return -E2BIG;
>>> +    if (fpos)
>>> +        *fpos = offset;
>>> +    return strm->fd;
>>> +}
>>> +
>>> +int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
>>> +{
>>> +    struct erofs_diskbufstrm *strm = dbufstrm + sid;
>>> +
>>> +    if (strm->tailoffset & (strm->alignsize - 1)) {
>>> +        strm->tailoffset = round_up(strm->tailoffset, strm->alignsize);
>>> +        if (lseek(strm->fd, strm->tailoffset + strm->devpos,
>>> +              SEEK_SET) != strm->tailoffset + strm->devpos)
>>> +            return -EIO;
>>> +    }
>>> +    if (*off)
>>> +        *off = db->offset + strm->devpos;
>>
>>
>> if (off)
>>     *off = db->offset + strm->devpos;
> 
> Thanks, fixed.
> 
>>
>> ?
>>
>>> +    db->offset = strm->tailoffset;
>>> +    db->sp = strm;
>>> +    ++strm->count;
>>> +    strm->locked = true;    /* TODO: need a real lock for MT */
>>> +    return strm->fd;
>>> +}
>>> +
>>> +void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64 len)
>>> +{
>>> +    struct erofs_diskbufstrm *strm = db->sp;
>>> +
>>> +    DBG_BUGON(!strm);
>>> +    DBG_BUGON(!strm->locked);
>>> +    DBG_BUGON(strm->tailoffset != db->offset);
>>> +    strm->tailoffset += len;
>>> +}
>>> +
>>> +void erofs_diskbuf_close(struct erofs_diskbuf *db)
>>> +{
>>> +    struct erofs_diskbufstrm *strm = db->sp;
>>> +
>>> +    DBG_BUGON(!strm);
>>> +    DBG_BUGON(strm->count <= 1);
>>> +    --strm->count;
>>> +    db->sp = NULL;
>>> +}
>>> +
>>> +int erofs_tmpfile(void)
>>> +{
>>> +#define    TRAILER        "tmp.XXXXXXXXXX"
>>> +    char buf[PATH_MAX];
>>> +    int fd;
>>> +    umode_t u;
>>> +
>>> +    (void)snprintf(buf, sizeof(buf), "%s/" TRAILER,
>>> +               getenv("TMPDIR") ?: "/tmp");
>>> +
>>> +    fd = mkstemp(buf);
>>> +    if (fd < 0)
>>> +        return -errno;
>>> +
>>> +    unlink(buf);
>>> +    u = umask(0);
>>> +    (void)umask(u);
>>> +    (void)fchmod(fd, 0666 & ~u);
>>> +    return fd;
>>> +}
>>> +
>>> +int erofs_diskbuf_init(unsigned int nstrms)
>>> +{
>>> +    struct erofs_diskbufstrm *strm;
>>> +
>>> +    strm = calloc(nstrms + 1, sizeof(*strm));
>>> +    if (!strm)
>>> +        return -ENOMEM;
>>> +    strm[nstrms].fd = -1;
>>> +    dbufstrm = strm;
>>> +
>>> +    for (; strm < dbufstrm + nstrms; ++strm) {
>>> +        struct stat st;
>>> +
>>> +        /* try to use the devfd for regfiles on stream 0 */
>>> +        if (strm == dbufstrm && sbi.devsz == INT64_MAX) {
>>> +            strm->devpos = 1ULL << 40;
>>> +            if (!ftruncate(sbi.devfd, strm->devpos << 1)) {
>>> +                strm->fd = dup(sbi.devfd);
>>> +                if (lseek(strm->fd, strm->devpos,
>>> +                      SEEK_SET) != strm->devpos)
>>> +                    return -EIO;
>>> +                goto setupone;
>>> +            }
>>> +        }
>>> +        strm->devpos = 0;
>>> +        strm->fd = erofs_tmpfile();
>>> +        if (strm->fd < 0)
>>> +            return -ENOSPC;
>>> +setupone:
>>> +        strm->tailoffset = 0;
>>> +        strm->count = 1;
>>> +        if (fstat(strm->fd, &st))
>>> +            return -errno;
>>> +        strm->alignsize = max_t(u32, st.st_blksize, getpagesize());
>>> +        ++strm;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +void erofs_diskbuf_exit(void)
>>> +{
>>> +    struct erofs_diskbufstrm *strm;
>>> +
>>> +    if (!dbufstrm)
>>> +        return;
>>> +
>>> +    for (strm = dbufstrm; strm->fd >= 0; ++strm) {
>>> +        DBG_BUGON(strm->count != 1);
>>> +
>>> +        close(strm->fd);
>>> +        strm->fd = -1;
>>> +    }
>>> +}
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index 37aa79e..4dc8260 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -16,6 +16,7 @@
>>>   #endif
>>>   #include <dirent.h>
>>>   #include "erofs/print.h"
>>> +#include "erofs/diskbuf.h"
>>>   #include "erofs/inode.h"
>>>   #include "erofs/cache.h"
>>>   #include "erofs/io.h"
>>> @@ -121,10 +122,12 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>>>       list_del(&inode->i_hash);
>>>       if (inode->i_srcpath)
>>>           free(inode->i_srcpath);
>>> -    if (inode->with_tmpfile)
>>> -        fclose(inode->i_tmpfile);
>>> -    else if (inode->i_link)
>>> +    if (inode->with_diskbuf) {
>>> +        erofs_diskbuf_close(inode->i_diskbuf);
>>> +        free(inode->i_diskbuf);
>>> +    } else if (inode->i_link) {
>>>           free(inode->i_link);
>>> +    }
>>>       free(inode);
>>>       return 0;
>>>   }
>>> @@ -454,12 +457,11 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>>>       return 0;
>>>   }
>>> -int erofs_write_file(struct erofs_inode *inode, int fd)
>>> +int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
>>>   {
>>>       int ret;
>>> -    if (!inode->i_size)
>>> -        return 0;
>>> +    DBG_BUGON(!inode->i_size);
>>>       if (cfg.c_chunkbits) {
>>>           inode->u.chunkbits = cfg.c_chunkbits;
>>> @@ -475,7 +477,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd)
>>>           if (!ret || ret != -ENOSPC)
>>>               return ret;
>>> -        ret = lseek(fd, 0, SEEK_SET);
>>> +        ret = lseek(fd, fpos, SEEK_SET);
>>>           if (ret < 0)
>>>               return -errno;
>>>       }
>>
>>
>> It seems that erofs_blob_write_chunked_file() has not been adapted to
>> the new erofs_diskbuf API?
> 
> I have no idea why it needs to be adapted, doesn't it work?

Oh, thanks for catching. I will fix this soon.

Thanks,
Gao Xiang

