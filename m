Return-Path: <linux-erofs+bounces-2129-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBBpJ82FcWk1IAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2129-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 03:05:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE660AFE
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 03:04:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxPX73Wjkz2yFm;
	Thu, 22 Jan 2026 13:04:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769047495;
	cv=none; b=ag3ZjOpIzBVWpAYzxviXchxMxg2MwJrHJELtbacfaChaZzf5CzxOvFph5dzHrxYZCukp6Ily7iJXrJorpCC+QyNID7rToDMOhW7htaJWMAzBGrUkBUvo27dv30F5seXblPz4G063yi8PBnodJPPcAFPs7Xup6IfIamorb7Uc17NBFLLp99jrl7MJ4PdV/p6MXRMzVNhLYOk6fa/udAXgum8y4JbRe9bIBVHiicbVP11aOfw1P+YQLeubgKVopqRF/FJFIhDPbHR9QbYsfAjZEc/pnwjNokw/q7BF7piEa5w5EwkMNVuP8EM3t3HJrFG0fnubDrjX5qM8hgjvKKr+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769047495; c=relaxed/relaxed;
	bh=pjBU57D4TjxwIIOOVNScuETf05WBuw5C2ll+Ng0tcIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F97k8V3kMm+X4LhKSjmDGHYCZ/soH2Q1ohfPbJ6kLncL1ZlFFEa/Mys4ibMUGMJ5J9HUg6AUPPTzUIlxGsrn5ZOObDMC7RwKv73VSgfLRIysoc16SPG6L9VOSxoM3hOq0AzWTsbOe87b+TMERl35ualoJozHxjKfggrOmQ24gr2N2r+nw+qRvkyaA41gCL/XjYSvkv2mQIdhJvVDpBctYHGx8hawOenhz2rB6eYmDpYC+G1mPlYDp1Cou9akT5dUGuajJPG8YUOv4tjDPzv4T8RiEGobsbGVmJw39cQyC7RxBHuf5ZuDacwHAR7SkD9P+9nJxOXKDjU5dYHQEs+wew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i/xnU3MD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i/xnU3MD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxPX51tJVz2xQC
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 13:04:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769047486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pjBU57D4TjxwIIOOVNScuETf05WBuw5C2ll+Ng0tcIw=;
	b=i/xnU3MDCXlzbzHXFd84K/zzRuMfQxd2ZM7W1o55J53lPnMutfHfWzl6RP1uOfR3NJkWRf9/e5RnDKysiLOKq5JBVpniO9hxC+XB6mKs0CGVhwpwd4eEG2S2s1jI8U0glNK9LYX0hSRLtqeIYO+onz7Qp4m63R3nWv8UV6neHsY=
Received: from 30.221.131.199(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxaV-IZ_1769047484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 10:04:44 +0800
Message-ID: <cccc173e-1e25-4e07-bb25-1bdf99231014@linux.alibaba.com>
Date: Thu, 22 Jan 2026 10:04:44 +0800
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
Subject: Re: [PATCH v3] erofs-utils: mkfs: add `--xattr-inode-digest` option
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20260121031940.1017-1-hsiangkao@linux.alibaba.com>
 <c459dbda-7050-4bdf-bc8c-5dd98b297298@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c459dbda-7050-4bdf-bc8c-5dd98b297298@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2129-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 95EE660AFE
X-Rspamd-Action: no action



On 2026/1/22 09:08, Hongbo Li wrote:
> Hi, Xiang
> 
> On 2026/1/21 11:19, Gao Xiang wrote:
>> Based on the original Hongbo's version [1], it enables storing the
>> SHA-256 digest of each inode as an extended attribute, in preparation
>> for the upcoming page cache sharing feature.
>>
>> Example usage:
>>   $ mkfs.erofs --xattr-inode-digest=system.erofs.fingerprint [-zlz4hc] foo.erofs foo/
>>
>> [1] https://lore.kernel.org/r/20251118015849.228939-1-lihongbo22@huawei.com
>>
>> Co-developed-by: Hongbo Li <lihongbo22@huawei.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Tested-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>> v2: https://lore.kernel.org/r/20251229180646.3017326-4-hsiangkao@linux.alibaba.com
>> v3:
>>   - Support the hidden xattr namespace, so that user programs cannot
>>     access inode fingerprints via normal mounts in any case.
>>
>>   include/erofs/internal.h |   2 +
>>   include/erofs/xattr.h    |   2 +
>>   include/erofs_fs.h       |   4 +-
>>   lib/inode.c              |  46 +++++++++-
>>   lib/super.c              |  13 ++-
>>   lib/xattr.c              |  19 +++-
>>   mkfs/main.c              | 187 ++++++++++++++++++++++-----------------
>>   7 files changed, 182 insertions(+), 91 deletions(-)
>>
>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>> index 26bf612..ef019a5 100644
>> --- a/include/erofs/internal.h
>> +++ b/include/erofs/internal.h
>> @@ -130,6 +130,7 @@ struct erofs_sb_info {
>>       u32 xattr_prefix_start;
>>       u8 xattr_prefix_count;
>> +    u8 ishare_xattr_prefix_id;
>>       struct erofs_xattr_prefix_item *xattr_prefixes;
>>       struct erofs_vfile bdev;
>> @@ -190,6 +191,7 @@ EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
>>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
>> +EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
>>   #define EROFS_I_EA_INITED_BIT    0
>>   #define EROFS_I_Z_INITED_BIT    1
>> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
>> index 941bed7..9654636 100644
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
>> index 887f37f..8b0d155 100644
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
>> index 299ec46..e3ee79a 100644
>> --- a/lib/inode.c
>> +++ b/lib/inode.c
>> @@ -31,6 +31,7 @@
>>   #include "liberofs_metabox.h"
>>   #include "liberofs_private.h"
>>   #include "liberofs_rebuild.h"
>> +#include "sha256.h"
>>   static inline bool erofs_is_special_identifier(const char *path)
>>   {
>> @@ -1954,6 +1955,37 @@ static int erofs_prepare_dir_inode(const struct erofs_mkfs_btctx *ctx,
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
>>   static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
>>                        struct erofs_inode *inode)
>>   {
>> @@ -1973,11 +2005,18 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
>>               ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
>>               if (ctx.fd < 0)
>>                   return -errno;
>> -            __erofs_fallthrough;
>> -        default:
>>               break;
>> +        default:
>> +            goto out;
>>           }
>> -        if (ctx.fd >= 0 && cfg.c_compr_opts[0].alg &&
>> +
>> +        if (S_ISREG(inode->i_mode) && inode->i_size) {
>> +            ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
>> +            if (ret < 0)
>> +                return ret;
>> +        }
>> +
>> +        if (cfg.c_compr_opts[0].alg &&
>>               erofs_file_is_compressible(im, inode)) {
>>               ctx.ictx = erofs_prepare_compressed_file(im, inode);
>>               if (IS_ERR(ctx.ictx))
>> @@ -1989,6 +2028,7 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
>>                   return ret;
>>           }
>>       }
>> +out:
>>       return erofs_mkfs_go(btctx, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
>>   }
>> diff --git a/lib/super.c b/lib/super.c
>> index a203f96..0180087 100644
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
>> index 9b0f2ca..d8c7bff 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -1483,8 +1483,9 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
>>       if (!erofs_xattr_prefix_matches(prefix, &tnode->base_index,
>>                       &tnode->base_len)) {
>> -        free(tnode);
>> -        return -ENODATA;
>> +        /* Use internal hidden xattrs */
>> +        tnode->base_index = 0;
>> +        tnode->base_len = 0;
> 
> So, should we add parameter bool hidden to this helper to distinct the cases?
> 
> Others looks good to me!

Nope, just my own thought, I think for other xattr prefix cases
(if they really would like to add a hidden xattr prefix), that
should be okay too.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Hongbo
> 

