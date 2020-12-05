Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94862CFA43
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 08:36:17 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp1bL1gk1zDqfW
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 18:36:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607153774;
	bh=FXN989fHKNRrT1Ht+s7OqmqQokX0EgHFztik8IisHTg=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=TqNCXMgcCLbFsAm0ZUzTHH1tsDEtKwEmIZfpjQKUD8hf1IzAgf6x4EQsIwOf4WWpq
	 1LQ5IN74QTcBFA0N/Kx0fnutub0yCqTHxylbJu6muIRzLCiy1UQHToj2trUVbdyT1y
	 2LxD4byqkH3aaU97gK4vka8mMPoCQe0CesyOESCa8fxZjhvdNGs02gh9pfJ/fTJQFK
	 TnmzjPxpb1rYuS2BFO1gG3X/fYWYMoGZ8SZpdIF5zYqgYfbnTEYVM15y3tSAokJ85W
	 hdUPLQ48RTaJ2AHbApFlqpvxPNaKE0+ZKM3ApaXS+PxskU4zproJZhZF3ekwLlpcvU
	 OxjnqBW6duvGA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=bckti4Xp; dkim-atps=neutral
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp1b80vJ8zDqbl
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 18:36:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607153744; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=WhDYIAV+phPzGXEO/g9rCMIdupZQQcgmOEZ4YCJHI1E=;
 b=bckti4XpzwQtPBE9JZlYYt6Q8SNVJ7CN5uoybZTdAcsXy81kSXkqN2eIDvcUAjGSxXLh8/Z3aWC1+b11LhG6LfMmDlCEXdrPz/eqWWGH7x5vX/Q7eADI6/QmDfZA4cQhmXL4k+ZwspDWn8Kfven2J3X2j7CypK8xSVuYaFiwEPE=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2271816|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_news_journal|0.0117554-0.00120863-0.987036;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04423; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UHZO4L3_1607153741; 
Received: from 172.168.2.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UHZO4L3_1607153741) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Dec 2020 15:35:42 +0800
Subject: Re: [PATCH] erofs-utils: xattr: fix OOB access due to alignment
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20201127143359.667374-1-hsiangkao@redhat.com>
Message-ID: <d13bbb6f-a4b7-568b-8ad8-a3b3b4094b7f@aliyun.com>
Date: Sat, 5 Dec 2020 15:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127143359.667374-1-hsiangkao@redhat.com>
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



On 2020/11/27 22:33, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> erofs_buf_write_bhops can only be safely used for block-aligned
> buffers, otherwise, it could write random out-of-bound data due
> to buffer alignment. Such random data is meaningless but it does
> harm to reproducable builds.
> 
> Fixes: 116ac0a254fc ("erofs-utils: introduce shared xattr support")
> Reported-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  lib/xattr.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
