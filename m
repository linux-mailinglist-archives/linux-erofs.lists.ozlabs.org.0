Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAB91B854
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 09:30:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MZAURAY0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9RtZ4sYrz3cXC
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 17:30:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MZAURAY0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9RtV4mCpz3cF6
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 17:30:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719559838; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eyQs0tMPU81R2eg4ZErSJAcR3SHyXy5n22wLWs/5v64=;
	b=MZAURAY0F0Y8AcoGZMxPKO4hXEGN+hyO53IK9JbxDcBrbj9ZYZX43KgUGJVh4GhmgtYkWbVsnJaOiA6pnHBjL67WlMUqQIB5Z2Vf/tddAYufIzxDjGOyT07/hd866nhl+99EhEt16EHkNjIQ+0VGtStOKERyvByKmxWxs/8fJYI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PYgHp_1719559835;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PYgHp_1719559835)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:30:36 +0800
Message-ID: <47a91a45-7e36-45e0-891f-475adca77f59@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:30:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] cachefiles: propagate errors from vfs_getxattr()
 to avoid infinite loop
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-5-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-5-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In cachefiles_check_volume_xattr(), the error returned by vfs_getxattr()
> is not passed to ret, so it ends up returning -ESTALE, which leads to an
> endless loop as follows:
> 
> cachefiles_acquire_volume
> retry:
>    ret = cachefiles_check_volume_xattr
>      ret = -ESTALE
>      xlen = vfs_getxattr // return -EIO
>      // The ret is not updated when xlen < 0, so -ESTALE is returned.
>      return ret
>    // Supposed to jump out of the loop at this judgement.
>    if (ret != -ESTALE)
>        goto error_dir;
>    cachefiles_bury_object
>      //  EIO causes rename failure
>    goto retry;
> 
> Hence propagate the error returned by vfs_getxattr() to avoid the above
> issue. Do the same in cachefiles_check_auxdata().
> 
> Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
> Fixes: 72b957856b0c ("cachefiles: Implement metadata/coherency data storage in xattrs")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

It looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
