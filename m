Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23E5892DE
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 21:46:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lyj6N4ppyz305v
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 05:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VTSFzdP4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VTSFzdP4;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lyj6L17jSz2xjf
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Aug 2022 05:46:34 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3C62BB82368;
	Wed,  3 Aug 2022 19:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88134C433C1;
	Wed,  3 Aug 2022 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659555989;
	bh=YPzPBZHY7knItXdca8YjlPbaIioCC/ezF45Cwjvt2Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTSFzdP4NY4aWWOBoKwpjA8/NpLQtDOYD4URYS5xGGcj4vB9peTQZSYzjTG8o3LGO
	 IxVUS6m8AFDvTUtgI7WlFFjzAI5YYAwHWQSwPWvEPCXQyxMuwGe8hUZLhsTdLqojXc
	 MCVx17ctLR2Befq0okxeSPt1oZKbMioxjVeDom47YQidej6Wf0uplDzWCrXUxOwlZO
	 /xPQy4xqg/mGBW8kZYVb2t+k0egllrGFsB03dtD8fh/pn9JcBgYPGuMFN3hZFH6sYy
	 Co+87jLfr80xeSL0k7GJACC3yvCYO6SDMk41jymmYzi0wIOyYD4aiLOzYUNTILZfyV
	 LHAu/RQu1nyPw==
Date: Thu, 4 Aug 2022 03:46:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: Sheng Yong <shengyong@oppo.com>
Subject: Re: [RFC PATCH 2/3] erofs-utils: fuse: export erofs_xattr_foreach
Message-ID: <YurQkH7D/Ch/clT0@debian>
Mail-Followup-To: Sheng Yong <shengyong@oppo.com>, xiang@kernel.org,
	bluce.lee@aliyun.com, linux-erofs@lists.ozlabs.org, chao@kernel.org
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-3-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220803142223.3962974-3-shengyong@oppo.com>
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

Hi Yong,

On Wed, Aug 03, 2022 at 10:22:22PM +0800, Sheng Yong wrote:
> This patch exports erofs_xattr_foreach() to iterate all xattrs.
> Each xattr entry is handled by operations defined in `struct
> xattr_iter_ops'.
> 

Thanks for your hard effort! 

Could we import in-kernel xattr implementation with verify enabled
(or unify these implementations) instead?

( Jianan ported a kernel implementation before, could we enhance
  it with verification?
  https://lore.kernel.org/r/20220728120910.61636-1-jnhuang@linux.alibaba.com)

Thanks,
Gao Xiang

> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>  fsck/main.c           |  83 ++++------------------------
>  include/erofs/xattr.h |   7 ++-
>  lib/xattr.c           | 123 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+), 74 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 5a2f659..237ccc1 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -14,6 +14,7 @@
>  #include "erofs/compress.h"
>  #include "erofs/decompress.h"
>  #include "erofs/dir.h"
> +#include "erofs/xattr.h"
> 
>  static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
> 
> @@ -283,82 +284,18 @@ static int erofs_check_sb_chksum(void)
>         return 0;
>  }
> 
> -static int erofs_verify_xattr(struct erofs_inode *inode)
> +static int erofs_verify_xattr_entry(const struct erofs_xattr_entry *entry)
>  {
> -       unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
> -       unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
> -       erofs_off_t addr;
> -       unsigned int ofs, xattr_shared_count;
> -       struct erofs_xattr_ibody_header *ih;
> -       struct erofs_xattr_entry *entry;
> -       int i, remaining = inode->xattr_isize, ret = 0;
> -       char buf[EROFS_BLKSIZ];
> -
> -       if (inode->xattr_isize == xattr_hdr_size) {
> -               erofs_err("xattr_isize %d of nid %llu is not supported yet",
> -                         inode->xattr_isize, inode->nid | 0ULL);
> -               ret = -EFSCORRUPTED;
> -               goto out;
> -       } else if (inode->xattr_isize < xattr_hdr_size) {
> -               if (inode->xattr_isize) {
> -                       erofs_err("bogus xattr ibody @ nid %llu",
> -                                 inode->nid | 0ULL);
> -                       ret = -EFSCORRUPTED;
> -                       goto out;
> -               }
> -       }
> -
> -       addr = iloc(inode->nid) + inode->inode_isize;
> -       ret = dev_read(0, buf, addr, xattr_hdr_size);
> -       if (ret < 0) {
> -               erofs_err("failed to read xattr header @ nid %llu: %d",
> -                         inode->nid | 0ULL, ret);
> -               goto out;
> -       }
> -       ih = (struct erofs_xattr_ibody_header *)buf;
> -       xattr_shared_count = ih->h_shared_count;
> -
> -       ofs = erofs_blkoff(addr) + xattr_hdr_size;
> -       addr += xattr_hdr_size;
> -       remaining -= xattr_hdr_size;
> -       for (i = 0; i < xattr_shared_count; ++i) {
> -               if (ofs >= EROFS_BLKSIZ) {
> -                       if (ofs != EROFS_BLKSIZ) {
> -                               erofs_err("unaligned xattr entry in xattr shared area @ nid %llu",
> -                                         inode->nid | 0ULL);
> -                               ret = -EFSCORRUPTED;
> -                               goto out;
> -                       }
> -                       ofs = 0;
> -               }
> -               ofs += xattr_entry_size;
> -               addr += xattr_entry_size;
> -               remaining -= xattr_entry_size;
> -       }
> -
> -       while (remaining > 0) {
> -               unsigned int entry_sz;
> +       return 0;
> +}
> 
> -               ret = dev_read(0, buf, addr, xattr_entry_size);
> -               if (ret) {
> -                       erofs_err("failed to read xattr entry @ nid %llu: %d",
> -                                 inode->nid | 0ULL, ret);
> -                       goto out;
> -               }
> +struct xattr_iter_ops erofs_verify_xattr_ops = {
> +       .verify = erofs_verify_xattr_entry,
> +};
> 
> -               entry = (struct erofs_xattr_entry *)buf;
> -               entry_sz = erofs_xattr_entry_size(entry);
> -               if (remaining < entry_sz) {
> -                       erofs_err("xattr on-disk corruption: xattr entry beyond xattr_isize @ nid %llu",
> -                                 inode->nid | 0ULL);
> -                       ret = -EFSCORRUPTED;
> -                       goto out;
> -               }
> -               addr += entry_sz;
> -               remaining -= entry_sz;
> -       }
> -out:
> -       return ret;
> +static int erofs_verify_xattr(struct erofs_inode *inode)
> +{
> +       return erofs_xattr_foreach(inode, &erofs_verify_xattr_ops, NULL);
>  }
> 
>  static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 226e984..c592d47 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -45,10 +45,15 @@ extern "C"
>  #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
>  #endif
> 
> +struct xattr_iter_ops {
> +       int (*verify)(const struct erofs_xattr_entry *entry);
> +};
> +
>  int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
>  char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
>  int erofs_build_shared_xattrs_from_path(const char *path);
> -
> +int erofs_xattr_foreach(struct erofs_inode *vi, struct xattr_iter_ops *ops,
> +                       void *data);
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/lib/xattr.c b/lib/xattr.c
> index c8ce278..92c155d 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -714,3 +714,126 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
>         DBG_BUGON(p > size);
>         return buf;
>  }
> +
> +static struct erofs_xattr_entry *read_xattr_entry(erofs_blk_t addr,
> +                                                 char *buf, size_t size)
> +{
> +       struct erofs_xattr_entry *entry;
> +       size_t entry_sz = sizeof(struct erofs_xattr_entry);
> +       int ret;
> +
> +       if (size < entry_sz)
> +               return ERR_PTR(-ERANGE);
> +
> +       ret = dev_read(0, buf, addr, entry_sz);
> +       if (ret) {
> +               erofs_err("failed to read xattr entry at addr %x: %d",
> +                         addr, ret);
> +               return ERR_PTR(ret);
> +       }
> +
> +       entry = (struct erofs_xattr_entry *)buf;
> +       entry_sz = erofs_xattr_entry_size(entry);
> +       if (size < entry_sz)
> +               return ERR_PTR(-ERANGE);
> +
> +       ret = dev_read(0, buf, addr, entry_sz);
> +       if (ret) {
> +               erofs_err("failed to read xattr entry at addr %x: %d",
> +                         addr, ret);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return entry;
> +}
> +
> +int erofs_xattr_foreach(struct erofs_inode *vi, struct xattr_iter_ops *ops,
> +                       void *data)
> +{
> +       unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
> +       unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
> +       erofs_off_t addr;
> +       unsigned int ofs, xattr_shared_count;
> +       struct erofs_xattr_ibody_header *ih;
> +       struct erofs_xattr_entry *entry;
> +       int i, remaining = vi->xattr_isize, ret = 0;
> +       char buf[EROFS_BLKSIZ];
> +
> +       if (vi->xattr_isize == xattr_hdr_size) {
> +               erofs_err("xattr_isize %d of nid %llu is not supported yet",
> +                         vi->xattr_isize, vi->nid | 0ULL);
> +               return -EFSCORRUPTED;
> +       } else if (vi->xattr_isize < xattr_hdr_size) {
> +               if (vi->xattr_isize) {
> +                       erofs_err("bogus xattr ibody @ nid %llu",
> +                                 vi->nid | 0ULL);
> +                       return -EFSCORRUPTED;
> +               }
> +       }
> +
> +       addr = iloc(vi->nid) + vi->inode_isize;
> +       ret = dev_read(0, buf, addr, xattr_hdr_size);
> +       if (ret < 0) {
> +               erofs_err("failed to read xattr header @ nid %llu: %d",
> +                         vi->nid | 0ULL, ret);
> +               return ret;
> +       }
> +       ih = (struct erofs_xattr_ibody_header *)buf;
> +       xattr_shared_count = ih->h_shared_count;
> +
> +       ofs = erofs_blkoff(addr) + xattr_hdr_size;
> +       addr += xattr_hdr_size;
> +       ret = dev_read(0, buf, addr, xattr_entry_size * xattr_shared_count);
> +       remaining -= xattr_hdr_size;
> +       for (i = 0; i < xattr_shared_count; ++i) {
> +               unsigned int xattr_id;
> +               erofs_blk_t xattr_addr;
> +               char tmp[EROFS_BLKSIZ];
> +
> +               if (ofs >= EROFS_BLKSIZ) {
> +                       if (ofs != EROFS_BLKSIZ) {
> +                               erofs_err("unaligned xattr entry in xattr shared area @ nid %llu",
> +                                         vi->nid | 0ULL);
> +                               return -EFSCORRUPTED;
> +                       }
> +                       ofs = 0;
> +               }
> +
> +               xattr_id = le32_to_cpu(*((__le32 *)buf + i));
> +               xattr_addr = sbi.xattr_blkaddr * EROFS_BLKSIZ +  4 * xattr_id;
> +
> +               entry = read_xattr_entry(xattr_addr, tmp, EROFS_BLKSIZ);
> +               if (IS_ERR(entry))
> +                       return PTR_ERR(entry);
> +
> +               if (ops->verify) {
> +                       ret = ops->verify(entry);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +
> +               ofs += xattr_entry_size;
> +               addr += xattr_entry_size;
> +               remaining -= xattr_entry_size;
> +       }
> +
> +       while (remaining > 0) {
> +               unsigned int entry_sz;
> +
> +               entry = read_xattr_entry(addr, buf, EROFS_BLKSIZ);
> +               if (IS_ERR(entry))
> +                       return PTR_ERR(entry);
> +               entry_sz = erofs_xattr_entry_size(entry);
> +
> +               if (ops->verify) {
> +                       ret = ops->verify(entry);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               addr += entry_sz;
> +               remaining -= entry_sz;
> +       }
> +
> +       return ret;
> +
> +}
> --
> 2.25.1
> 
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人使用（包含个人及群组）。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，请立即以电子邮件通知发件人并删除本邮件及其附件。
> 
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!
