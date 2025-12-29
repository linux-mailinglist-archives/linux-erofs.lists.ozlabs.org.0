Return-Path: <linux-erofs+bounces-1640-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF910CE6DA5
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 14:15:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfxXs1NxGz2xgv;
	Tue, 30 Dec 2025 00:15:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767014125;
	cv=none; b=dl45kDYYfenyx0cmOwIIDk5Z82HnRlvainhgzThbRlGZciYz1Di71vD2CnXdq+XJtN/eHHUexM0KZ0gPayjrlKLjZt/aqnFei5TDBQL0pSGJHp9fQ4jxqfDQMNI0W9eCXH13LkG6QRSNZ74t2GuTTvE7iAs1B1Uy62iW3i1mz1Uw+AehFXuIZQnvixhgBO4kh/ne9RCtmRIEJWU0ZLOnT37+aP1+u/OsUj2rnXd4CVhp8txW1/ZPuU3bYTSmQISFK88gOqsMCPrtRMDfh8wtos1Cq2qYFxzVcpjOfnehP5zQoaJmxHuskPGX0opOAGEH8bTM1qZHZsIrMpgmHJ/aqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767014125; c=relaxed/relaxed;
	bh=iTCXemi7bvaTj8G+Umgiwm1zJOWR6gvdo+Y6bxV7CLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=naBATgEt4euZm3pCUVP03pPf7UQGYy/+qhL4u94azYmBDBJISEVed3eSvhCAKp2YZ4xdpaiPBJbEn7L2LNYC+Moqe4372VZGlO85ythnAQeyK/80zNdAFp4nlrQF4kdvHCkPU3+bYmyqV8pV+DHM/gwfvgx5Ln/zPG4CFxqWkZATj8ysZQCMyo9LvJHq5j6ykT3vlIN4ggdMz1FIh1UfO/YK4MaLklB9dmBcTuz5aDB6jyCm9ZCbEm4CAynEgrvEZZZlG0rYYf0IxlBvTe7DYGcZLUQ5PCoB/qIKZ7ZZa0xJ+Da2QpN5L5JF71NaAbzmEb45cXC2K/8p83YlU/cnRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JFS8PqsL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JFS8PqsL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfxXn6nK5z2xdV
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 00:15:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767014114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iTCXemi7bvaTj8G+Umgiwm1zJOWR6gvdo+Y6bxV7CLY=;
	b=JFS8PqsLnxHhy5qNyDNf7WzWBLDWLFCzISUMaaCq8jrhkcWIuExym3Gx80W9ZKCwLhTfpOISD0B/9rZFzT+T/WQyQnH/fUN5JI8yC/8nzmsxsbPovw4vXqwAXN2+LOTHvRGFeT1WqrgCHc/WSJ/rxZCY/UhwfD6lvTqlx/F9rBk=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvtX79t_1767014111 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 21:15:13 +0800
Message-ID: <ef44bbc7-dbeb-48f8-b880-e3797a34ba15@linux.alibaba.com>
Date: Mon, 29 Dec 2025 21:15:10 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: mkfs: add `--inode-digest-xattr` option
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20251229074959.2147985-1-hsiangkao@linux.alibaba.com>
 <20251229074959.2147985-2-hsiangkao@linux.alibaba.com>
 <9b732162-18a4-442a-b862-50a2cdd4a1a9@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9b732162-18a4-442a-b862-50a2cdd4a1a9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/12/29 21:06, Hongbo Li wrote:
> Hi Xiang,
> 
> On 2025/12/29 15:49, Gao Xiang wrote:
>> Based on the original Hongbo's version [1], it enables storing the
>> SHA-256 digest of each inode as an extended attribute, in preparation
>> for the upcoming page cache sharing feature.
>>
>> Example usage:
>>   $ mkfs.erofs --inode-digest-xattr=trusted.erofs.fingerprint [-zlz4hc] foo.erofs foo/
>>
>> Co-developed-by: Hongbo Li <lihongbo22@huawei.com>
>> [1] https://lore.kernel.org/r/20251118015849.228939-1-lihongbo22@huawei.com
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   include/erofs/internal.h |  2 ++
>>   include/erofs/xattr.h    |  2 ++
>>   include/erofs_fs.h       |  4 +++-
>>   lib/inode.c              | 44 ++++++++++++++++++++++++++++++++++++++--
>>   lib/super.c              | 13 ++++++++++--
>>   lib/xattr.c              | 14 ++++++++++++-
>>   mkfs/main.c              | 27 ++++++++++++++++++++----
>>   7 files changed, 96 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>> index 62594b877151..5798f10e89c2 100644
>> --- a/include/erofs/internal.h
>> +++ b/include/erofs/internal.h
>> @@ -130,6 +130,7 @@ struct erofs_sb_info {
>>       u32 xattr_prefix_start;
>>       u8 xattr_prefix_count;
>> +    u8 ishare_xattr_prefix_id;
>>       struct erofs_xattr_prefix_item *xattr_prefixes;
>>       struct erofs_vfile bdev;
>> @@ -189,6 +190,7 @@ EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
>>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
>> +EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
>>   #define EROFS_I_EA_INITED_BIT    0
>>   #define EROFS_I_Z_INITED_BIT    1
>> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
>> index 941bed778956..96546364f316 100644
>> --- a/include/erofs/xattr.h
>> +++ b/include/erofs/xattr.h
>> @@ -33,6 +33,8 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode);
>>   int erofs_load_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path,
>>                          long inlinexattr_tolerance);
>>   int erofs_xattr_insert_name_prefix(const char *prefix);
>> +int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
>> +                  const char *prefix);
>>   void erofs_xattr_cleanup_name_prefixes(void);
>>   int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
>>   int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
>> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
>> index 887f37faba59..8b0d155f8c4c 100644
>> --- a/include/erofs_fs.h
>> +++ b/include/erofs_fs.h
>> @@ -17,6 +17,7 @@
>>   #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
>>   #define EROFS_FEATURE_COMPAT_XATTR_FILTER    0x00000004
>>   #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX    0x00000010
>> +#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS    0x00000020
>>   /*
>>    * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
>> @@ -82,7 +83,8 @@ struct erofs_super_block {
>>       __le32 xattr_prefix_start;    /* start of long xattr prefixes */
>>       __le64 packed_nid;    /* nid of the special packed inode */
>>       __u8 xattr_filter_reserved; /* reserved for xattr name filter */
>> -    __u8 reserved[3];
>> +    __u8 ishare_xattr_prefix_id;
>> +    __u8 reserved[2];
>>       __le32 build_time;    /* seconds added to epoch for mkfs time */
>>       __le64 rootnid_8b;    /* (48BIT on) nid of root directory */
>>       __le64 reserved2;
>> diff --git a/lib/inode.c b/lib/inode.c
>> index 1d08e39317c0..c6085a52281a 100644
>> --- a/lib/inode.c
>> +++ b/lib/inode.c
>> @@ -31,6 +31,7 @@
>>   #include "liberofs_metabox.h"
>>   #include "liberofs_private.h"
>>   #include "liberofs_rebuild.h"
>> +#include "sha256.h"
>>   static inline bool erofs_is_special_identifier(const char *path)
>>   {
>> @@ -1879,6 +1880,37 @@ static int erofs_prepare_dir_inode(struct erofs_importer *im,
>>       return 0;
>>   }
>> +static int erofs_set_inode_fingerprint(struct erofs_inode *inode, int fd,
>> +                       erofs_off_t pos)
>> +{
>> +    u8 ishare_xattr_prefix_id = inode->sbi->ishare_xattr_prefix_id;
>> +    erofs_off_t remaining = inode->i_size;
>> +    struct erofs_vfile vf = { .fd = fd };
>> +    struct sha256_state md;
>> +    u8 out[32 + sizeof("sha256:") - 1];
>> +    int ret;
>> +
>> +    if (!ishare_xattr_prefix_id)
>> +        return 0;
>> +    erofs_sha256_init(&md);
>> +    do {
>> +        u8 buf[32768];
>> +
>> +        ret = erofs_io_pread(&vf, buf,
>> +                     min_t(u64, remaining, sizeof(buf)), pos);
>> +        if (ret < 0)
>> +            return ret;
>> +        if (ret > 0)
>> +            erofs_sha256_process(&md, buf, ret);
>> +        remaining -= ret;
>> +        pos += ret;
>> +    } while (remaining);
>> +    erofs_sha256_done(&md, out + sizeof("sha256:") - 1);
>> +    memcpy(out, "sha256:", sizeof("sha256:") - 1);
>> +    return erofs_setxattr(inode, ishare_xattr_prefix_id, "",
>> +                  out, sizeof(out));
>> +}
>> +
>>   static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
>>                        struct erofs_inode *inode)
>>   {
>> @@ -1899,9 +1931,16 @@ static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
>>                   return -errno;
>>               __erofs_fallthrough;
>>           default:
>> -            break;
>> +            goto out;
> 
> We should keep use break here to set inode fingerprint in following step.
> 
> Another is that, here we use "erofs_set_inode_fingerprint" to hook the fingerprint xattr in inode->xattrs, but the "erofs_prepare_xattr_ibody" has calculated the xattr_size before. So should we move the "erofs_prepare_xattr_ibody" later so that to make sure the fingerprint xattr is set?

Yeah, thanks for catching this, I will refine another version later.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>> +        }
>> +
>> +        if (S_ISREG(inode->i_mode) && inode->i_size) {
>> +            ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
>> +            if (ret < 0)
>> +                return ret;
>>           }
>> -        if (ctx.fd >= 0 && cfg.c_compr_opts[0].alg &&
>> +
>> +        if (cfg.c_compr_opts[0].alg &&
>>               erofs_file_is_compressible(im, inode)) {
>>               ctx.ictx = erofs_prepare_compressed_file(im, inode);
>>               if (IS_ERR(ctx.ictx))
>> @@ -1913,6 +1952,7 @@ static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
>>                   return ret;
>>           }
>>       }
>> +out:
>>       return erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
>>   }
>> diff --git a/lib/super.c b/lib/super.c
>> index e54aff2d4ab7..a4837e5702ed 100644
>> --- a/lib/super.c
>> +++ b/lib/super.c
>> @@ -146,7 +146,15 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
>>       sbi->build_time = le32_to_cpu(dsb->build_time);
>>       memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
>> -
>> +    if (erofs_sb_has_ishare_xattrs(sbi)) {
>> +        if (dsb->ishare_xattr_prefix_id >= sbi->xattr_prefix_count) {
>> +            erofs_err("invalid ishare xattr prefix id %d",
>> +                  dsb->ishare_xattr_prefix_id);
>> +            return -EFSCORRUPTED;
>> +        }
>> +        sbi->ishare_xattr_prefix_id =
>> +            dsb->ishare_xattr_prefix_id | EROFS_XATTR_LONG_PREFIX;
>> +    }
>>       ret = z_erofs_parse_cfgs(sbi, dsb);
>>       if (ret)
>>           return ret;
>> @@ -160,7 +168,6 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
>>           free(sbi->devs);
>>           sbi->devs = NULL;
>>       }
>> -
>>       sbi->sb_valid = !ret;
>>       return ret;
>>   }
>> @@ -206,6 +213,8 @@ int erofs_writesb(struct erofs_sb_info *sbi)
>>           .extra_devices = cpu_to_le16(sbi->extra_devices),
>>           .devt_slotoff = cpu_to_le16(sbi->devt_slotoff),
>>           .packed_nid = cpu_to_le64(sbi->packed_nid),
>> +        .ishare_xattr_prefix_id = sbi->ishare_xattr_prefix_id &
>> +            EROFS_XATTR_LONG_PREFIX_MASK,
>>       };
>>       char *buf;
>>       int ret;
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index b6b1a5e600fb..764aee3be3c3 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -1495,9 +1495,21 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
>>       }
>>       tnode->index = EROFS_XATTR_LONG_PREFIX | ea_prefix_count;
>> -    ea_prefix_count++;
>>       init_list_head(&tnode->list);
>>       list_add_tail(&tnode->list, &ea_name_prefixes);
>> +    return ea_prefix_count++;
>> +}
>> +
>> +int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
>> +                  const char *prefix)
>> +{
>> +    int err;
>> +
>> +    err = erofs_xattr_insert_name_prefix(prefix);
>> +    if (err < 0)
>> +        return err;
>> +    sbi->ishare_xattr_prefix_id = EROFS_XATTR_LONG_PREFIX | err;
>> +    erofs_sb_set_ishare_xattrs(sbi);
>>       return 0;
>>   }
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index aaa0300bca1b..7fd6e8419d44 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -102,6 +102,7 @@ static struct option long_options[] = {
>>   #endif
>>       {"zD", optional_argument, NULL, 536},
>>       {"ZI", optional_argument, NULL, 537},
>> +    {"inode-digest-xattr", required_argument, NULL, 538},
>>       {0, 0, 0, 0},
>>   };
>> @@ -1262,7 +1263,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
>>           case 19:
>>               errno = 0;
>>               opt = erofs_xattr_insert_name_prefix(optarg);
>> -            if (opt) {
>> +            if (opt < 0) {
>>                   erofs_err("failed to parse xattr name prefix: %s",
>>                         erofs_strerror(opt));
>>                   return opt;
>> @@ -1424,6 +1425,14 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
>>               else
>>                   mkfscfg.inode_metazone = false;
>>               break;
>> +        case 538:
>> +            err = erofs_xattr_set_ishare_prefix(&g_sbi, optarg);
>> +            if (err < 0) {
>> +                erofs_err("failed to parse ishare name: %s",
>> +                      erofs_strerror(err));
>> +                return err;
>> +            }
>> +            break;
>>           case 'V':
>>               version();
>>               exit(0);
>> @@ -1878,9 +1887,12 @@ int main(int argc, char **argv)
>>               goto exit;
>>           }
>> -        if (cfg.c_extra_ea_name_prefixes)
>> -            erofs_xattr_flush_name_prefixes(&importer,
>> -                            mkfs_plain_xattr_pfx);
>> +        err = erofs_xattr_flush_name_prefixes(&importer,
>> +                              mkfs_plain_xattr_pfx);
>> +        if (err) {
>> +            erofs_err("failed to flush long xattr prefixes: %s",
>> +                  erofs_strerror(err));
>> +        }
>>           root = erofs_new_inode(&g_sbi);
>>           if (IS_ERR(root)) {
>> @@ -1888,6 +1900,13 @@ int main(int argc, char **argv)
>>               goto exit;
>>           }
>>       } else {
>> +        err = erofs_xattr_flush_name_prefixes(&importer,
>> +                              mkfs_plain_xattr_pfx);
>> +        if (err) {
>> +            erofs_err("failed to flush long xattr prefixes: %s",
>> +                  erofs_strerror(err));
>> +        }
>> +
>>           root = erofs_rebuild_make_root(&g_sbi);
>>           if (IS_ERR(root)) {
>>               err = PTR_ERR(root);


