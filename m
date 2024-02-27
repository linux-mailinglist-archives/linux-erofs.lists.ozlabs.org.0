Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8B869A7E
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 16:36:24 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZJ/yC5L8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkhRB2rZ6z3cXY
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 02:36:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZJ/yC5L8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkhR52x4sz3c7s
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Feb 2024 02:36:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709048168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dNk2rcKm/gNzjhGebmjEwojvC6m9tAhAZ0E9EKysQQw=;
	b=ZJ/yC5L8d+sTpEONZgkehzOdlESHmFd4RkWd5DW5AOafZGAaMsMDCOC0SYnIpt6G5ABqNVSlloNrZ7JN+4bfyG7hifBBnGjvyIPL2ij6XbeS5GzEtN9+FOVaGuzLPoruwV6s4VhoFDsiWG29SLm8WLwcVKzcJFm9tdyXP3YwOz4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1N2WP._1709048165;
Received: from 192.168.71.98(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1N2WP._1709048165)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 23:36:06 +0800
Message-ID: <55d8b3a9-9130-4e6a-9aef-006f72d26b7f@linux.alibaba.com>
Date: Tue, 27 Feb 2024 23:36:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: mkfs: Support tar source without data
To: Mike Baynton <mike@mbaynton.com>, linux-erofs@lists.ozlabs.org
References: <20359e03-f7aa-4531-b0d1-b76e9950f233@linux.alibaba.com>
 <20240227084221.342635-1-hsiangkao@linux.alibaba.com>
 <CAM56kJTvu7cQZmK5-6SKb=ObkHsYtG663gsRQOAndj=3UY-aaQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAM56kJTvu7cQZmK5-6SKb=ObkHsYtG663gsRQOAndj=3UY-aaQ@mail.gmail.com>
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



On 2024/2/27 23:22, Mike Baynton wrote:
> On Tue, Feb 27, 2024 at 2:42 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Mike,
>>    Just some minor changes for applying to -dev development codebase.
>> Does it look good to you?
>>    (I will apply this version to -experimental for testing.)
> 
> Looks pretty good to me, thank you! Looks like I should have created
> the patch against -dev.
> 
> This modifies the --help text and includes tar twice, was that intentional?
> 
>   --tar=X               generate a full or index-only image from a
> tarball(-ish) source
>                         (X = f|i|headerball; f=full mode, i=index mode,
>                                              headerball=file data is
> omited in the source stream)
>   --tar=[fi]            generate an image from tarball(s)

Ah, very sorry about that.  And thanks for catching this,
let me drop the redundant one directly.

Thanks,
Gao Xiang
