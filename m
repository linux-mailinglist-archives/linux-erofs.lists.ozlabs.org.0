Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699C36FE59
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 18:17:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWyDz0J1Rz2yy4
	for <lists+linux-erofs@lfdr.de>; Sat,  1 May 2021 02:17:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1619799427;
	bh=1av70SqJ8TRTwkjgUH1DTcaHezUYSTwhFt95PLWV/Gc=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RjexVlEGat3EcWnvVxOpdqZaX3YlV+CXAjXUMVywsH6kJDCm+YPiub2bdUvdqJyfp
	 UyKYGmcwH8rx2VIAnL4f6mgeiwXP1VgumHCjCrsaWUkbuAcpPMCBoBUv7uPsdxSNTA
	 WUyOEhpr1tLuo+sQAxF+AZdF/QXhpz4flRbkV0kww79M7s66fzfLVZ2erzFbnju4s1
	 XbgytQ8okBp0bww2iL9QfWGdeXowVVdVcyc+Y/xT/9OOWmB/RGCkN+Z/1e1fBG+76o
	 3o9YPWsyORRBAVjtRRFNU2ikwoy9l7GfvlgKE78b+9qjdi3hF3KPd7HX8N218Umqhu
	 3KljQb63HrEdg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.53;
 helo=out30-53.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=mImjgfeU; dkim-atps=neutral
Received: from out30-53.freemail.mail.aliyun.com
 (out30-53.freemail.mail.aliyun.com [115.124.30.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWyDw0gv3z2xfk
 for <linux-erofs@lists.ozlabs.org>; Sat,  1 May 2021 02:17:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1982603|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0243805-0.0018705-0.973749;
 FP=0|0|0|0|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=3; RT=3; SR=0;
 TI=SMTPD_---0UXHjxXv_1619799418; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UXHjxXv_1619799418) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 01 May 2021 00:16:58 +0800
Subject: Re: [PATCH v4 3/5] erofs-utils: manpage: add missing -C option for
 big pcluster
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20210430040345.17120-1-xiang@kernel.org>
 <20210430040345.17120-3-xiang@kernel.org>
Message-ID: <57518166-05a4-ccee-27f8-e02539eaafdd@aliyun.com>
Date: Sat, 1 May 2021 00:16:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430040345.17120-3-xiang@kernel.org>
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



On 2021/4/30 12:03, Gao Xiang wrote:
> Update the manpage as well.
> 
> Signed-off-by: Gao Xiang <xiang@kernel.org>
It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,

