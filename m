Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C886B2DA
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 16:13:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlHtF2ZH7z3dSj
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 02:13:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlHt92m46z3bsJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 02:13:19 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 4BD351008EE03;
	Wed, 28 Feb 2024 23:13:15 +0800 (CST)
Received: from [192.168.25.134] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id A78BF37C80D;
	Wed, 28 Feb 2024 23:13:12 +0800 (CST)
Message-ID: <80bdfb95-d29b-4ae5-b5d4-f09daf9a1197@sjtu.edu.cn>
Date: Wed, 28 Feb 2024 23:13:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] erofs-utils: mkfs: introduce inner-file
 multi-threaded compression
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
 <20240225142759.340165-5-zhaoyifan@sjtu.edu.cn>
 <5968a9e0-7c02-4596-aae5-a04f5730c318@linux.alibaba.com>
Content-Language: en-US
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <5968a9e0-7c02-4596-aae5-a04f5730c318@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2/28/24 17:57, Gao Xiang wrote:
>
>
> On 2024/2/25 22:27, Yifan Zhao wrote:
>> Currently, the creation of EROFS compressed image creation is
>> single-threaded, which suffers from performance issues. This patch
>> attempts to address it by compressing the large file in parallel.
>>
>> Specifically, each input file larger than 16MB is splited into segments,
>> and each worker thread compresses a segment as if it were a separate
>> file. Finally, the main thread merges all the compressed segments.
>>
>> Multi-threaded compression is not compatible with -Ededupe,
>> -E(all-)fragments and -Eztailpacking for now.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
>> Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
>> ---
>>   include/erofs/compress.h |   1 +
>>   lib/compress.c           | 690 ++++++++++++++++++++++++++++++++-------
>>   lib/compressor.c         |   2 +
>>   3 files changed, 575 insertions(+), 118 deletions(-)
>>
>> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
>> index 046640b..2699334 100644
>> --- a/include/erofs/compress.h
>> +++ b/include/erofs/compress.h
>> @@ -15,6 +15,7 @@ extern "C"
>>   #include "internal.h"
>>     #define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
>> +#define EROFS_COMPR_QUEUE_SZ (EROFS_CONFIG_COMPR_MAX_SZ * 2)
>>     void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
>>   int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
>> diff --git a/lib/compress.c b/lib/compress.c
>> index 9611102..f98feae 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -8,6 +8,9 @@
>>   #ifndef _LARGEFILE64_SOURCE
>>   #define _LARGEFILE64_SOURCE
>>   #endif
>> +#ifndef _GNU_SOURCE
>> +#define _GNU_SOURCE
>> +#endif
>>   #include <string.h>
>>   #include <stdlib.h>
>>   #include <unistd.h>
>> @@ -20,6 +23,16 @@
>>   #include "erofs/block_list.h"
>>   #include "erofs/compress_hints.h"
>>   #include "erofs/fragments.h"
>> +#ifdef EROFS_MT_ENABLED
>> +#include "erofs/workqueue.h"
>> +#endif
>> +#ifdef HAVE_LINUX_FALLOC_H
>> +#include <linux/falloc.h>
>> +#endif
>> +
>> +#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
>> +#define USE_PER_WORKER_TMPFILE 1
>> +#endif
>>     /* compressing configuration specified by users */
>>   struct erofs_compress_cfg {
>> @@ -33,29 +46,84 @@ struct z_erofs_extent_item {
>>       struct z_erofs_inmem_extent e;
>>   };
>>   +struct z_erofs_file_compress_ctx {
>
> struct z_erofs_compressed_inode_ctx  would be better
>
>> +    struct erofs_inode *inode;
>> +    int fd;
>> +    unsigned int pclustersize;
>> +
>> +    u32 tof_chksum;
>> +    bool fix_dedupedfrag;
>> +    bool fragemitted;
>> +};
>> +
>>   struct z_erofs_vle_compress_ctx {
>
> I think we'd better to rename this as
>
> struct z_erofs_compressed_segment_ctx
>
>> -    u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
>> +    struct z_erofs_file_compress_ctx *fctx;
>> +
>> +    u8 *queue;
>>       struct list_head extents;
>>       struct z_erofs_extent_item *pivot;
>>   -    struct erofs_inode *inode;
>> -    struct erofs_compress_cfg *ccfg;
>> +    struct erofs_compress *chandle;
>> +    char *destbuf;
>>   -    u8 *metacur;
>>       unsigned int head, tail;
>>       erofs_off_t remaining;
>> -    unsigned int pclustersize;
>>       erofs_blk_t blkaddr;        /* pointing to the next blkaddr */
>> +    erofs_blk_t compressed_blocks;
>>       u16 clusterofs;
>>   -    u32 tof_chksum;
>> -    bool fix_dedupedfrag;
>> -    bool fragemitted;
>> +    int seg_num, seg_idx;
>> +    FILE *tmpfile;
>> +    off_t tmpfile_off;
>> +};
>> +
>> +struct z_erofs_write_index_ctx {
>
> why we need this structure, I'd like to fold it in
>
> struct z_erofs_compressed_inode_ctx.
>
>> +    struct erofs_inode *inode;
>> +    struct list_head *extents;
>> +    u16 clusterofs;
>> +    erofs_blk_t blkaddr, blkoff;
>
> I don't like this approach, let's just fix
> extents->blkaddr in a loop together.
>
>> +    u8 *metacur;
>>   };
>>   +#ifdef EROFS_MT_ENABLED
>> +struct erofs_compress_wq_private {
>> +    bool init;
>> +    u8 *queue;
>> +    char *destbuf;
>> +    struct erofs_compress_cfg *ccfg;
>> +    FILE* tmpfile;
>> +};
>> +
>> +struct erofs_compress_work {
>> +    /* Note: struct erofs_work must be the first member */
>> +    struct erofs_work work;
>> +    struct z_erofs_vle_compress_ctx ctx;
>> +
>> +    unsigned int alg_id;
>> +    char *alg_name;
>> +    unsigned int comp_level;
>> +    unsigned int dict_size;
>> +
>> +    int ret;
>> +
>> +    struct erofs_compress_work *next;
>> +};
>> +
>> +static struct {
>> +    struct erofs_workqueue wq;
>> +    struct erofs_compress_work *idle;
>
> Does this need a mutex protection?
>
I think `idle` is written by the main thread only in this patch and the 
mutex is unnecessary.

>> +    pthread_mutex_t mutex;
>> +    pthread_cond_t cond;
>> +    int nfini;
>> +} z_erofs_mt_ctrl;
>> +#endif
>> +
>> +static bool z_erofs_mt_enabled;
>> +static u8 *z_erofs_global_queue;
>> +
>>   #define Z_EROFS_LEGACY_MAP_HEADER_SIZE Z_EROFS_FULL_INDEX_ALIGN(0)
>>   -static void z_erofs_write_indexes_final(struct 
>> z_erofs_vle_compress_ctx *ctx)
>> +static void z_erofs_write_indexes_final(struct 
>> z_erofs_write_index_ctx *ctx)
>>   {
>>       const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
>>       struct z_erofs_lcluster_index di;
>> @@ -71,7 +139,7 @@ static void z_erofs_write_indexes_final(struct 
>> z_erofs_vle_compress_ctx *ctx)
>>       ctx->metacur += sizeof(di);
>>   }
>>   -static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx 
>> *ctx,
>> +static void z_erofs_write_extent(struct z_erofs_write_index_ctx *ctx,
>>                    struct z_erofs_inmem_extent *e)
>>   {
>>       struct erofs_inode *inode = ctx->inode;
>> @@ -99,10 +167,15 @@ static void z_erofs_write_extent(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>           di.di_advise = cpu_to_le16(advise);
>>             if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
>> -            !e->compressedblks)
>> +            !e->compressedblks) {
>>               di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
>> -        else
>> +        } else if (z_erofs_mt_enabled) {
>> +            di.di_u.blkaddr =
>> +                cpu_to_le32(ctx->blkaddr + ctx->blkoff);
>> +            ctx->blkoff += e->compressedblks;
>
> so we don't need this at all.
>
>> +        } else {
>>               di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
>> +        }
>>           memcpy(ctx->metacur, &di, sizeof(di));
>>           ctx->metacur += sizeof(di);
>>   @@ -144,10 +217,15 @@ static void z_erofs_write_extent(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>                   Z_EROFS_LCLUSTER_TYPE_HEAD1;
>>                 if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
>> -                !e->compressedblks)
>> +                !e->compressedblks) {
>>                   di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 
>> 32);
>> -            else
>> +            } else if (z_erofs_mt_enabled) {
>> +                di.di_u.blkaddr =
>> +                    cpu_to_le32(ctx->blkaddr + ctx->blkoff);
>> +                ctx->blkoff += e->compressedblks;
>
> same here.
>
>> +            } else {
>>                   di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
>> +            }
>>                 if (e->partial) {
>>                   DBG_BUGON(e->raw);
>> @@ -170,12 +248,12 @@ static void z_erofs_write_extent(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>       ctx->clusterofs = clusterofs + count;
>>   }
>>   -static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx 
>> *ctx)
>> +static void z_erofs_write_indexes(struct z_erofs_write_index_ctx *ctx)
>>   {
>>       struct z_erofs_extent_item *ei, *n;
>>         ctx->clusterofs = 0;
>> -    list_for_each_entry_safe(ei, n, &ctx->extents, list) {
>> +    list_for_each_entry_safe(ei, n, ctx->extents, list) {
>>           z_erofs_write_extent(ctx, &ei->e);
>>             list_del(&ei->list);
>> @@ -188,11 +266,12 @@ static bool z_erofs_need_refill(struct 
>> z_erofs_vle_compress_ctx *ctx)
>>   {
>>       const bool final = !ctx->remaining;
>>       unsigned int qh_aligned, qh_after;
>> +    struct erofs_inode *inode = ctx->fctx->inode;
>>         if (final || ctx->head < EROFS_CONFIG_COMPR_MAX_SZ)
>>           return false;
>>   -    qh_aligned = round_down(ctx->head, 
>> erofs_blksiz(ctx->inode->sbi));
>> +    qh_aligned = round_down(ctx->head, erofs_blksiz(inode->sbi));
>>       qh_after = ctx->head - qh_aligned;
>>       memmove(ctx->queue, ctx->queue + qh_aligned, ctx->tail - 
>> qh_aligned);
>>       ctx->tail -= qh_aligned;
>> @@ -212,14 +291,13 @@ static void z_erofs_commit_extent(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>         list_add_tail(&ei->list, &ctx->extents);
>>       ctx->clusterofs = (ctx->clusterofs + ei->e.length) &
>> -            (erofs_blksiz(ctx->inode->sbi) - 1);
>> -
>> +              (erofs_blksiz(ctx->fctx->inode->sbi) - 1);
>>   }
>>     static int z_erofs_compress_dedupe(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>                      unsigned int *len)
>>   {
>> -    struct erofs_inode *inode = ctx->inode;
>> +    struct erofs_inode *inode = ctx->fctx->inode;
>>       const unsigned int lclustermask = (1 << 
>> inode->z_logical_clusterbits) - 1;
>>       struct erofs_sb_info *sbi = inode->sbi;
>>       struct z_erofs_extent_item *ei = ctx->pivot;
>> @@ -318,13 +396,14 @@ out:
>>   static int write_uncompressed_extent(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>                        unsigned int len, char *dst)
>>   {
>> -    struct erofs_sb_info *sbi = ctx->inode->sbi;
>> +    struct erofs_inode *inode = ctx->fctx->inode;
>> +    struct erofs_sb_info *sbi = inode->sbi;
>>       unsigned int count = min(erofs_blksiz(sbi), len);
>>       unsigned int interlaced_offset, rightpart;
>>       int ret;
>>         /* write interlaced uncompressed data if needed */
>> -    if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
>> +    if (inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
>>           interlaced_offset = ctx->clusterofs;
>>       else
>>           interlaced_offset = 0;
>> @@ -335,11 +414,19 @@ static int write_uncompressed_extent(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>       memcpy(dst + interlaced_offset, ctx->queue + ctx->head, 
>> rightpart);
>>       memcpy(dst, ctx->queue + ctx->head + rightpart, count - 
>> rightpart);
>>   -    erofs_dbg("Writing %u uncompressed data to block %u",
>> -          count, ctx->blkaddr);
>> -    ret = blk_write(sbi, dst, ctx->blkaddr, 1);
>> -    if (ret)
>> -        return ret;
>> +    if (ctx->tmpfile) {
>> +        erofs_dbg("Writing %u uncompressed data to tmpfile", count);
>> +        ret = fwrite(dst, erofs_blksiz(sbi), 1, ctx->tmpfile);
>> +        if (ret != 1)
>> +            return -EIO;
>> +        fflush(ctx->tmpfile);
>> +    } else {
>> +        erofs_dbg("Writing %u uncompressed data to block %u", count,
>> +              ctx->blkaddr);
>> +        ret = blk_write(sbi, dst, ctx->blkaddr, 1);
>> +        if (ret)
>> +            return ret;
>> +    }
>>       return count;
>>   }
>>   @@ -384,8 +471,8 @@ static void tryrecompress_trailing(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>                      void *in, unsigned int *insize,
>>                      void *out, unsigned int *compressedsize)
>>   {
>> -    struct erofs_sb_info *sbi = ctx->inode->sbi;
>> -    static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
>> +    struct erofs_sb_info *sbi = ctx->fctx->inode->sbi;
>> +    char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
>
> does tryrecompress_trailing() work? if it doesn't work,
> let's leave the old code as-is.
>
>>       unsigned int count;
>>       int ret = *compressedsize;
>>   @@ -409,7 +496,7 @@ static void tryrecompress_trailing(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>   static bool z_erofs_fixup_deduped_fragment(struct 
>> z_erofs_vle_compress_ctx *ctx,
>>                          unsigned int len)
>>   {
>> -    struct erofs_inode *inode = ctx->inode;
>> +    struct erofs_inode *inode = ctx->fctx->inode;
>>       struct erofs_sb_info *sbi = inode->sbi;
>>       const unsigned int newsize = ctx->remaining + len;
>>   @@ -417,9 +504,10 @@ static bool 
>> z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
>>         /* try to fix again if it gets larger (should be rare) */
>>       if (inode->fragment_size < newsize) {
>> -        ctx->pclustersize = min_t(erofs_off_t, 
>> z_erofs_get_max_pclustersize(inode),
>> -                      roundup(newsize - inode->fragment_size,
>> -                          erofs_blksiz(sbi)));
>> +        ctx->fctx->pclustersize =
>> +            min_t(erofs_off_t, z_erofs_get_max_pclustersize(inode),
>> +                  roundup(newsize - inode->fragment_size,
>> +                      erofs_blksiz(sbi)));
>>           return false;
>>       }
>>   @@ -439,26 +527,31 @@ static bool 
>> z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
>>   static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx 
>> *ctx,
>>                     struct z_erofs_inmem_extent *e)
>>   {
>> -    static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + 
>> EROFS_MAX_BLOCK_SIZE];
>> -    struct erofs_inode *inode = ctx->inode;
>> +    static char
>> +        global_dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + 
>> EROFS_MAX_BLOCK_SIZE];
>> +    char *dstbuf = ctx->destbuf ? ctx->destbuf : global_dstbuf;
>
>     char *dstbuf = ctx->destbuf ? : global_dstbuf;
>
I believe this grammar is a GCC extension [1] which is not part of the 
standard. Will it sacrifice portability ?

[1] https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html


Other reviews LGTM and will be included in the next version of this 
patchset.


Thanks,

Yifan Zhao

>
> Thanks,
> Gao Xiang
