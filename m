Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE5923C4B
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 13:21:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j3CGEB3y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD0q20wcgz3fsF
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 21:21:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j3CGEB3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD0pw2mpGz3cVn
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 21:21:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719919281; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g3FfLa38QT48EIV46aMrwvioqKKyNJul8T+K4R+plSk=;
	b=j3CGEB3yIzH4F7qv77Ie5HCgFhlcrJk3/6yiJTUcEL1caI5+Lh/OduHFhDBtZF1ha/dnhdbszLMF1niJhDOeHpuXGUvytTawMRRE/nOQSQK1DqeW2QSgPVtJsUMRX2ahLmg/5U6d0AI3kkoLXJx5ySDLgn6xjnBKGsZDa41CaRM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9ig10G_1719919278;
Received: from 30.97.48.142(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9ig10G_1719919278)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 19:21:19 +0800
Message-ID: <1f6bd0e6-0251-452f-868f-f95f6290a825@linux.alibaba.com>
Date: Tue, 2 Jul 2024 19:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To: Greg KH <gregkh@linuxfoundation.org>
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
 <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
 <9e81761d-e769-4b14-b72c-77b74e707364@linux.alibaba.com>
 <2a427366-0f63-4024-a3b3-759a4f902061@linux.alibaba.com>
 <2024062733-cradle-imprecise-002f@gregkh>
 <2abcf8cf-5cfc-4932-a544-ee0788bb2ed3@linux.alibaba.com>
 <32dce802-692f-4050-b153-d5c4541fd835@linux.alibaba.com>
 <2024062757-throwaway-frugality-0637@gregkh>
 <62f71edc-b89d-4d5c-b51b-4eefb838d7fb@linux.alibaba.com>
 <2024070245-bleach-fountain-2018@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024070245-bleach-fountain-2018@gregkh>
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
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/2 16:46, Greg KH wrote:
> On Thu, Jun 27, 2024 at 10:03:38PM +0800, Gao Xiang wrote:
>>
>>

..

>>
>>>
>>> And if so, what is the git commit id of it in Linus's tree?
>>
>> commit 8bd90b6ae7856dd5000b75691d905b39b9ea5d6b upstream.
> 
> Now queued up, thanks.

Thanks Greg!

Thanks,
Gao Xiang

> 
> greg k-h
