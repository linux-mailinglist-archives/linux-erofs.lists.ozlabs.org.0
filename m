Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098AB78FAD9
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 11:32:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RcXr65V3Fz3c1L
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 19:32:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RcXqy4JPhz3bV2
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Sep 2023 19:32:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vr4eOWl_1693560740;
Received: from 30.15.248.80(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vr4eOWl_1693560740)
          by smtp.aliyun-inc.com;
          Fri, 01 Sep 2023 17:32:21 +0800
Message-ID: <afa9019b-ee47-e5fd-1d32-482525e6e476@linux.alibaba.com>
Date: Fri, 1 Sep 2023 17:32:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs-utils: lib: support importing xattrs from
 tarerofs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230831185819.98592-1-hsiangkao@linux.alibaba.com>
 <20230901072642.68200-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230901072642.68200-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/1/23 3:26 PM, Gao Xiang wrote:
> `SCHILY.xattr.attr` indicates a POSIX.1-2001 coded version of the
> Linux extended attributes.  Let's dump such xattrs to erofs images.
> 
> In addition, `LIBARCHIVE.xattr` is also supported, which uses
> URL-Encoding instead of the binary form.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>


Tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
> changes since v1:
>  - fix `SCHILY.xattr.attr` xattr value incorrect sizes reported by Jingbo.
> 
>  include/erofs/tar.h |   1 +
>  lib/tar.c           | 171 ++++++++++++++++++++++++++++++++++++++++++--
>  mkfs/main.c         |   4 +-
>  3 files changed, 171 insertions(+), 5 deletions(-)
> 
> diff --git a/include/erofs/tar.h b/include/erofs/tar.h
> index d5648f6..b50db1d 100644
> --- a/include/erofs/tar.h
> +++ b/include/erofs/tar.h
> @@ -13,6 +13,7 @@ extern "C"
>  
>  struct erofs_pax_header {
>  	struct stat st;
> +	struct list_head xattrs;
>  	bool use_mtime;
>  	bool use_size;
>  	bool use_uid;
> diff --git a/lib/tar.c b/lib/tar.c
> index 328ab98..53196c1 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -235,6 +235,131 @@ static struct erofs_dentry *tarerofs_get_dentry(struct erofs_inode *pwd, char *p
>  	return d;
>  }
>  
> +struct tarerofs_xattr_item {
> +	struct list_head list;
> +	char *kv;
> +	unsigned int len, namelen;
> +};
> +
> +int tarerofs_insert_xattr(struct list_head *xattrs,
> +			  char *kv, int namelen, int len, bool skip)
> +{
> +	struct tarerofs_xattr_item *item;
> +	char *nv;
> +
> +	DBG_BUGON(namelen >= len);
> +	list_for_each_entry(item, xattrs, list) {
> +		if (!strncmp(item->kv, kv, namelen + 1)) {
> +			if (skip)
> +				return 0;
> +			goto found;
> +		}
> +	}
> +
> +	item = malloc(sizeof(*item));
> +	if (!item)
> +		return -ENOMEM;
> +	item->kv = NULL;
> +	item->namelen = namelen;
> +	namelen = 0;
> +	list_add_tail(&item->list, xattrs);
> +found:
> +	nv = realloc(item->kv, len);
> +	if (!nv)
> +		return -ENOMEM;
> +	item->kv = nv;
> +	item->len = len;
> +	memcpy(nv + namelen, kv + namelen, len - namelen);
> +	return 0;
> +}
> +
> +int tarerofs_merge_xattrs(struct list_head *dst, struct list_head *src)
> +{
> +	struct tarerofs_xattr_item *item;
> +
> +	list_for_each_entry(item, src, list) {
> +		int ret;
> +
> +		ret = tarerofs_insert_xattr(dst, item->kv, item->namelen,
> +					    item->len, true);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +void tarerofs_remove_xattrs(struct list_head *xattrs)
> +{
> +	struct tarerofs_xattr_item *item, *n;
> +
> +	list_for_each_entry_safe(item, n, xattrs, list) {
> +		DBG_BUGON(!item->kv);
> +		free(item->kv);
> +		list_del(&item->list);
> +		free(item);
> +	}
> +}
> +
> +int tarerofs_apply_xattrs(struct erofs_inode *inode, struct list_head *xattrs)
> +{
> +	struct tarerofs_xattr_item *item;
> +	int ret;
> +
> +	list_for_each_entry(item, xattrs, list) {
> +		const char *v = item->kv + item->namelen + 1;
> +		unsigned int vsz = item->len - item->namelen - 1;
> +
> +		if (item->len <= item->namelen - 1) {
> +			DBG_BUGON(item->len < item->namelen - 1);
> +			continue;
> +		}
> +		item->kv[item->namelen] = '\0';
> +		erofs_dbg("Recording xattr(%s)=\"%s\" (of %u bytes) to file %s",
> +			  item->kv, v, vsz, inode->i_srcpath);
> +		ret = erofs_setxattr(inode, item->kv, v, vsz);
> +		if (ret == -ENODATA)
> +			erofs_err("Failed to set xattr(%s)=%s to file %s",
> +				  item->kv, v, inode->i_srcpath);
> +		else if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static const char lookup_table[65] =
> +	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
> +
> +static int base64_decode(const char *src, int len, u8 *dst)
> +{
> +	int i, bits = 0, ac = 0;
> +	const char *p;
> +	u8 *cp = dst;
> +
> +	if(!(len % 4)) {
> +		/* Check for and ignore any end padding */
> +		if (src[len - 2] == '=' && src[len - 1] == '=')
> +			len -= 2;
> +		else if (src[len - 1] == '=')
> +			--len;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		p = strchr(lookup_table, src[i]);
> +		if (p == NULL || src[i] == 0)
> +			return -2;
> +		ac += (p - lookup_table) << bits;
> +		bits += 6;
> +		if (bits >= 8) {
> +			*cp++ = ac & 0xff;
> +			ac >>= 8;
> +			bits -= 8;
> +		}
> +	}
> +	if (ac)
> +		return -1;
> +	return cp - dst;
> +}
> +
>  int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
>  {
>  	char *buf, *p;
> @@ -260,6 +385,7 @@ int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
>  		}
>  		kv = p + n;
>  		p += len;
> +		len -= n;
>  
>  		if (p[-1] != '\n') {
>  			ret = -EIO;
> @@ -330,6 +456,34 @@ int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
>  				}
>  				eh->st.st_gid = lln;
>  				eh->use_gid = true;
> +			} else if (!strncmp(kv, "SCHILY.xattr.",
> +				   sizeof("SCHILY.xattr.") - 1)) {
> +				char *key = kv + sizeof("SCHILY.xattr.") - 1;
> +
> +				--len; /* p[-1] == '\0' */
> +				ret = tarerofs_insert_xattr(&eh->xattrs, key,
> +						value - key - 1,
> +						len - (key - kv), false);
> +				if (ret)
> +					goto out;
> +			} else if (!strncmp(kv, "LIBARCHIVE.xattr.",
> +				   sizeof("LIBARCHIVE.xattr.") - 1)) {
> +				char *key;
> +				key = kv + sizeof("LIBARCHIVE.xattr.") - 1;
> +
> +				--len; /* p[-1] == '\0' */
> +				ret = base64_decode(value, len - (value - kv),
> +						    (u8 *)value);
> +				if (ret < 0) {
> +					ret = -EFSCORRUPTED;
> +					goto out;
> +				}
> +
> +				ret = tarerofs_insert_xattr(&eh->xattrs, key,
> +						value - key - 1,
> +						value - key + ret, false);
> +				if (ret)
> +					goto out;
>  			} else {
>  				erofs_info("unrecognized pax keyword \"%s\", ignoring", kv);
>  			}
> @@ -416,6 +570,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
>  		eh.path = strdup(eh.path);
>  	if (eh.link)
>  		eh.link = strdup(eh.link);
> +	init_list_head(&eh.xattrs);
>  
>  restart:
>  	rem = tar->offset & 511;
> @@ -723,15 +878,23 @@ new_inode:
>  			}
>  		}
>  		inode->i_nlink++;
> -		ret = 0;
> -	} else if (!inode->i_nlink)
> +	} else if (!inode->i_nlink) {
>  		ret = erofs_init_empty_dir(inode);
> -	else
> -		ret = 0;
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = tarerofs_merge_xattrs(&eh.xattrs, &tar->global.xattrs);
> +	if (ret)
> +		goto out;
> +
> +	ret = tarerofs_apply_xattrs(inode, &eh.xattrs);
> +
>  out:
>  	if (eh.path != path)
>  		free(eh.path);
>  	free(eh.link);
> +	tarerofs_remove_xattrs(&eh.xattrs);
>  	return ret;
>  
>  invalid_tar:
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 16da9c0..4352e62 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -132,7 +132,9 @@ static void usage(void)
>  }
>  
>  static unsigned int pclustersize_packed, pclustersize_max;
> -static struct erofs_tarfile erofstar;
> +static struct erofs_tarfile erofstar = {
> +	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
> +};
>  static bool tar_mode;
>  
>  static int parse_extended_opts(const char *opts)

-- 
Thanks,
Jingbo
