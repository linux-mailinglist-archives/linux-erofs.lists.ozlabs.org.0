Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 636272BBD87
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 07:35:06 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdNvC5lZLzDr0f
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 17:35:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605940503;
	bh=oBgrlymSOCzlvROu+QsrxRWEsoqXos40Bb/0f/LT8dY=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=WkBj7o1CYQlPWJ0ZXjeWoewDtOc2ocGA26vZKBLSgX220Yh5OokCEcvDLePsEd3hV
	 n04wzaW/Xa18FthxZ9CpccXhH+NGyrk06JqNnPr+u+zGNTwQTbtnTEPSzRYc+x6zR2
	 sR+MHCmMcdt9pLgeVpffOPK2NyN2h4voVBYgqJRxcctvQT7U7FnHSZl5NtYD9R5/Ro
	 qz7fPc5I4zUjSL4vDiWW++P+GO5/924m10Aj0RXs0Erl5EValAz7XIctrXyi3OsV9Y
	 671b1eYAy6ZaqwxazHnfn3THIo+8EmkqnpHEpPmEs6tWsFQjmTvjputiLR4n992ZU/
	 ov9Y41eErTZvg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.14;
 helo=out30-14.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=o5pWleQc; dkim-atps=neutral
Received: from out30-14.freemail.mail.aliyun.com
 (out30-14.freemail.mail.aliyun.com [115.124.30.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdNv557dzzDqwm
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 17:34:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1605940477; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=QBXcVWMq23cZaLm0sZaKqjqcKWfN0RZQZbfv3J9UHd4=;
 b=o5pWleQcpF9aQ0FPqZd3VWOc9yfoPoLP4wwooEXqyN0EzwJu0hKFr+E52A+AFWyr1Jt9KACDby8w6/KYJx01MaOs/pnK9PyTjJ11aDYl9c3W+BQk/XJ7syMOBy6YDtU4iLtnFJa3R3Bt4Qq5eA0wQGpHsyMSbM+s1P1t7NpBFJs=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08884881|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_social|0.00361831-0.000529974-0.995852;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04423; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UG1Qswv_1605940476; 
Received: from 192.168.3.30(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UG1Qswv_1605940476) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 21 Nov 2020 14:34:37 +0800
Subject: Re: [PATCH v2 1/2] erofs-utils: drop known issue in README
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201121022623.3882-1-hsiangkao.ref@aol.com>
 <20201121022623.3882-1-hsiangkao@aol.com>
Message-ID: <4c8e89df-6d72-abcc-722d-23cd3e9444aa@aliyun.com>
Date: Sat, 21 Nov 2020 14:34:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201121022623.3882-1-hsiangkao@aol.com>
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



On 2020/11/21 10:26, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Since lz4-1.9.3 has been released,
> https://github.com/lz4/lz4/releases/tag/v1.9.3
> 
> Move this lz4hc issue (lz4 <= 1.9.2) to "Comments" instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> v2: fix "lz4 <= 1.8.2" to "lz4 <= 1.9.2" typo.

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
