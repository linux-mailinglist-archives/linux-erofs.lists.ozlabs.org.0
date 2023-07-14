Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E029E7534BF
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 10:10:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2PKk61HNz3cXh
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 18:10:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2PJX4z5pz3c47
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 18:09:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnL.86d_1689322144;
Received: from 30.97.49.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnL.86d_1689322144)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 16:09:05 +0800
Message-ID: <8e761590-4c62-8d80-64cc-457dec338326@linux.alibaba.com>
Date: Fri, 14 Jul 2023 16:09:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 REBASED] erofs-utils: introduce tarerofs
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230714065851.70583-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230714065851.70583-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/14 14:58, Jingbo Xu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Let's try to add a new mode "tarerofs" for mkfs.erofs.
> 
> It mainly aims at two use cases:
>   - Convert a tarball (or later tarballs with a merged view) into
>     a full EROFS image [--tar=f];
> 
>   - Generate an EROFS manifest image to reuse tar data [--tar=i],
>     which also enables EROFS 512-byte blocks.
> 
> The second use case is mainly prepared for OCI direct mount without
> OCI blob unpacking.  This also adds another `--aufs` option to
> transform aufs special files into overlayfs metadata.
> 
> [ Note that `--tar=f` generates lots of temporary files for now which
>    can impact performance since the original tar stream(s) may be
>    non-seekable. ]
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> changes:
> - rebase to origin/dev branch
> - remove commented code lines in tarerofs_parse_tar()
> ---
>   configure.ac              |   1 +
>   include/erofs/blobchunk.h |   4 +-
>   include/erofs/inode.h     |  12 +
>   include/erofs/internal.h  |   7 +-
>   include/erofs/tar.h       |  29 ++
>   include/erofs/xattr.h     |   4 +
>   lib/Makefile.am           |   3 +-
>   lib/blobchunk.c           |  47 ++-
>   lib/inode.c               | 194 ++++++---
>   lib/tar.c                 | 807 ++++++++++++++++++++++++++++++++++++++
>   lib/xattr.c               |  46 ++-
>   mkfs/main.c               | 134 +++++--
>   12 files changed, 1182 insertions(+), 106 deletions(-)
>   create mode 100644 include/erofs/tar.h
>   create mode 100644 lib/tar.c


I will apply this patch with the following diff applied too, mainly
since some random compiler (gcc 9.2.1) reports a weird warning like
below:

tar.c: In function ‘tarerofs_parse_tar’:
tar.c:697:22: warning: ‘st.st_rdev’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   697 |    inode->u.i_rdev = erofs_new_encode_dev(st.st_rdev);

but st.st_rdev is actually initialized.

Thanks,
Gao Xiang

-----------

diff --git a/lib/tar.c b/lib/tar.c
index ef45183..8edfe75 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -581,10 +581,12 @@ restart:
  	} else {
  		erofs_info("unrecognized typeflag %xh @ %llu - ignoring",
  			   th.typeflag, tar_offset);
+		(void)erofs_lskip(tar->fd, st.st_size);
  		ret = 0;
  		goto out;
  	}

+	st.st_rdev = 0;
  	if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
  		int major, minor;

@@ -599,8 +601,8 @@ restart:
  			erofs_err("invalid device minor @ %llu", tar_offset);
  			goto out;
  		}
-		st.st_rdev = (major << 8) | (minor & 0xff) | ((minor & ~0xff) << 12);

+		st.st_rdev = (major << 8) | (minor & 0xff) | ((minor & ~0xff) << 12);
  	} else if (th.typeflag == '1' || th.typeflag == '2') {
  		if (!eh.link)
  			eh.link = strndup(th.linkname, sizeof(th.linkname));

