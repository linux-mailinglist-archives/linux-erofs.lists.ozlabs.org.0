Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB0481940
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 05:15:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JPZgY2V88z3056
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 15:15:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JPZgQ6QQFz2xsL
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Dec 2021 15:15:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V0IJ-js_1640837668; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0IJ-js_1640837668) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 30 Dec 2021 12:14:30 +0800
Date: Thu, 30 Dec 2021 12:14:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 4/5] erofs: use meta buffers for xattr operations
Message-ID: <Yc0yJMgPGqUJ5Ju+@B-P7TQMD6M-0146.local>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
 <20211229041405.45921-5-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211229041405.45921-5-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 29, 2021 at 12:14:04PM +0800, Gao Xiang wrote:

...

>  
> @@ -659,6 +608,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	if (ret)
>  		return ret;
>  
> +	it.it.buf = __EROFS_BUF_INITIALIZER;
>  	it.dentry = dentry;
>  	it.buffer = buffer;
>  	it.buffer_size = buffer_size;
> @@ -669,6 +619,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	ret = inline_listxattr(&it);
>  	if (ret < 0 && ret != -ENOATTR)
>  		return ret;
> +	erofs_put_metabuf(&it.it.buf);
>  	return shared_listxattr(&it);

There is a bug here, I will fix it in the next version.

Thanks,
Gao Xiang

>  }
>  
> -- 
> 2.24.4
