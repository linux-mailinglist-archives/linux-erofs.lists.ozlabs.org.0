Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A48ACA8D
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 12:25:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ARbHFpCp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNLxM0Xchz3cZB
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 20:25:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ARbHFpCp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNLxF5lKDz3cQx
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 20:25:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713781530; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TvioAWeIxSSIl9wCtF/pXYCI+u21pfzAVY3/7/ShKE8=;
	b=ARbHFpCpfgrizqpUoeLnUhsufxcEF0Wv7p7z87+O2ccpgeAlKyf4SKULwGbGEij4JmJ1TzMPs11gN6rlyYZ/pZR72loDM3JMezj5+crdW75TKAWIOg5+KtVwzBBcaLiX0QFRm5INVRaj4x8o4WDiitu2kz78mCza8DNKZ8InZP8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W51vfY7_1713781527;
Received: from 30.221.150.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W51vfY7_1713781527)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 18:25:28 +0800
Message-ID: <8d751a33-af11-4aa8-8fad-cc24e825bde7@linux.alibaba.com>
Date: Mon, 22 Apr 2024 18:25:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240419123611.947084-2-libaokun1@huawei.com>
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/19/24 8:36 PM, Baokun Li wrote:

> @@ -761,12 +747,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>  
>  static void erofs_fc_free(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
> +
> +	if (!sbi)
> +		return;


This is the only difference comparing to the original code literally.
Is there any chance that fc->s_fs_info can be NULL when erofs_fc_free()
is called?

Otherwise looks good to me.



-- 
Thanks,
Jingbo
