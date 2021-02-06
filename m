Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F02311E6D
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Feb 2021 16:29:47 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DXx6c5rKyzDwjP
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Feb 2021 02:29:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612625384;
	bh=hfMPaa345vJ3bt2EoJYhoILeEv4EX1t2pP7RuQp3i5w=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=F3POMRf+QYjjDWDtEWBYvJYynE/aPnR/Xz4zyp5P8sFL7KsfZEzO+YbBTnS+E1nfL
	 MDi/kuWvLwpdpw6ElDksyN4pasLbSnWFjp89Dr6JSJxraKU2G4bcgpXX9OH8mEDKk8
	 ntu0dW3Oor2zqY9JYjFPCL8tegPuLOY8IyI4GtumCW5KAL0CBctS8RC9a0uhY2eRJp
	 IKL0gqMcxIxWceFxTNSJMb4AJFxCssGhGobaYQURlXsh/UIJvwT8uqRv+b+Zlv+gBJ
	 z88N7mPNA+k5dE4GURjtq1HSmj41pdLeFkEVfU2+OWkRIKKtLczrnf00S4/xn9o9Cv
	 RPaapnYUl6jQg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=fzkfbnj3; dkim-atps=neutral
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DXx6H4NRQzDwkk
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Feb 2021 02:29:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1612625361; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=b3VetzAb749+j8iqV2VZV2tUOoa/OOBSIKo5EmlC36s=;
 b=fzkfbnj3UBxk8h+84Y+XGSP7ptYNoAuZ/emKjTXSwcfBwHO2VaZezc3OzVa6GW+6K7OENk/KHyxrYJApEVRwibSvTasDt0IoUeVjGb7zvnTSnVdqqWIZvQW8vRu+IsF0287S5T7LII5prMJ+3bnGeML/Kd4Z+b6KpU+N/G8meRQ=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1582487|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.00362215-0.000703358-0.995675; FP=0|0|0|0|0|-1|-1|-1;
 HT=alimailimapcm10staff010182156082; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UO0r6lI_1612625360; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UO0r6lI_1612625360) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 06 Feb 2021 23:29:20 +0800
Subject: Re: [PATCH v7 2/3] erofs-utils: introduce erofs_bfind_for_attach()
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20210122171153.27404-1-hsiangkao@aol.com>
 <20210122171153.27404-3-hsiangkao@aol.com>
Message-ID: <16ba323e-c488-d5a1-87a6-d618f364b5aa@aliyun.com>
Date: Sat, 6 Feb 2021 23:29:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122171153.27404-3-hsiangkao@aol.com>
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



On 2021/1/23 1:11, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Seperate erofs_balloc() to make the logic more clearer.
> 
> Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  lib/cache.c | 81 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 31 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
