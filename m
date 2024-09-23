Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C097E44B
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 02:08:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBjy75yfvz2yPM
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 10:08:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727050110;
	cv=none; b=Sw0fh6dRKeuRmwiz3gdf4TVSmtqUZXxUnDOB1Aa+BsQZ6W+5xYR7qHKcxhODxzPEi/lxE324DeJAuT47kf+Bsj7wsyyqqLH92ITYqBmUbgD5rr1KSy5gNzc5MY7qTBVtWuXBEl+CzN6NjXhZ21riaLzOFQ4QfPRirdNdRZh9assgP1Snsf2f3lalIQI9vuZdRRcWaNEdK061qko3UUx7RwPVb30g7kZ5v+rksxdMVHXUyjgtfchryZCGr8pK6usfJ9XpuW2oB2GXbkcsTNY0J6W7RM3rADbsYY1XtK+4wFT04KYWNRpp+VDVvgwInwgpQ0w/P+5zwC1VESUS8ecrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727050110; c=relaxed/relaxed;
	bh=QeL52XbexEQQhcGM03hcns968M1iZQ1HyvYc4ZGRN8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRq4BheSklG4kZvTS2e6Ckw0HkOkvH/ZKOwSCsdk/EmdpGDtQ61Hpm+S+QWPan00UAqNXCLdtIoNWQpfil+/jOv4ehDrMISsOvSJCcSTKjQT0M3xVo6k9jlM0zQZtbO/Zev9NL9Sof5qSxPF0ktUtlJFS7Nn3sq9x2egBQWrOA6VPakz1q/S98GR+pKwjB4ABlu20FPgqbnRt61W/rbG2RZrdlj64/fr2/mYopQ4F2w6QMyqCtxbrC0IbtozXrSGkpUkA6h7ER+A6opTLtLNYPBZXzyneP0X/KsnfBHJsz5TNX8ap/jFXp2cEAwhl90QCvV19rU2qSGTP8mXQXCXuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cPLLKdCt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cPLLKdCt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBjy46794z2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 10:08:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727050103; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QeL52XbexEQQhcGM03hcns968M1iZQ1HyvYc4ZGRN8s=;
	b=cPLLKdCtgqg0CgkEBXtfvmyGRPBAcGTTXNQam8ooStiCBFRGoCfQ1xrhVSA8AR51OU06blXhM6GqJJRLeniHGTnuuC4zmtZbZNWt+jJdVpvXy6t1eBlikEClroymCBGM810ygyHc9AaKg+Ud/Sbade4yK8GP6+z9eIm1JwuaZN4=
Received: from 30.27.108.50(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFRXf5c_1727050099)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 08:08:21 +0800
Message-ID: <63307dbc-da27-42e6-86fb-ed446f04ede5@linux.alibaba.com>
Date: Mon, 23 Sep 2024 08:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix compressed packed inodes
To: Danny Lin <danny@orbstack.dev>, linux-erofs@lists.ozlabs.org
References: <20240916073835.77470-1-danny@orbstack.dev>
 <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
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

Hi Danny,

Thanks for the patch!
Sorry I somewhat missed the previous email..

On 2024/9/22 13:08, Danny Lin wrote:
> Gentle bump — let me know if anything needs to be changed!

Does the following change resolve the issue too?

Also I think it
Fixes: 2fdbd28ad4a3 ("erofs-utils: lib: fix uncompressed packed inode")

@@ -1927,7 +1926,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,

                 DBG_BUGON(!ictx);
                 ret = erofs_write_compressed_file(ictx);
-               if (ret && ret != -ENOSPC)
+               if (ret != -ENOSPC)
                          return ERR_PTR(ret);

                 ret = lseek(fd, 0, SEEK_SET);

Thanks,
Gao Xiang

> 
> Thanks,
> Danny

