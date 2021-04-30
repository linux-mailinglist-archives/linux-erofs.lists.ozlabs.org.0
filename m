Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E436FE51
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 18:15:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWyBW64Bpz2yy4
	for <lists+linux-erofs@lfdr.de>; Sat,  1 May 2021 02:14:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1619799299;
	bh=0fbQ05b6VEzzv+PNawFHM489kH8aiSlSB6CV4mxDpXU=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lvY+mo3EuVmJ9vAZ+N3qND8wOdTcTLZRcVzhiYj27Ja9idsZ1xvebFjnkXt00wR/l
	 Ymy7NFLCmQkrnUufT1dDgY6e2Ecn060akaHwz7OSKVCHmhMKBNhkRAzqewFxQ1VfrX
	 qoKH/Vt9LnMfWs9lk+VObg5lmNsPZDeUkNbT7FXMPda244tkvEEsiTiGmlWPhW26H5
	 7DK2hwXwPOEdqrRuid+Y+LDhTzse56AZNQgFOXS7jmHQdKv1Zi26JF3IzMR4zG1yBk
	 t2bsb8uepR5UnpUQK8xvpVGarl1aY5te+KzSdpP165u7qPKkGf/geyn3TMJghvMp1i
	 r03jkxmioE+hw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=Mh8JmoJr; dkim-atps=neutral
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWyBS1FhFz2y6N
 for <linux-erofs@lists.ozlabs.org>; Sat,  1 May 2021 02:14:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2507601|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0543826-0.00365727-0.94196;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04423; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UXHjxAA_1619799287; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UXHjxAA_1619799287) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 01 May 2021 00:14:47 +0800
Subject: Re: [PATCH 1/3] erofs-utils: sync up with in-kernel erofs_fs.h
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20210427023722.7996-1-xiang@kernel.org>
Message-ID: <20d517a9-499b-d5e3-f3ba-687a31fb036d@aliyun.com>
Date: Sat, 1 May 2021 00:14:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427023722.7996-1-xiang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/4/27 10:37, Gao Xiang wrote:
> This matches the latest in-kernel version.
> 
> Signed-off-by: Gao Xiang <xiang@kernel.org>
> ---
>  include/erofs_fs.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
