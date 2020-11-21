Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9D2BBD82
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 07:32:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdNqr2CSxzDr0f
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 17:32:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605940328;
	bh=DyAgMUSJJvl71lUP52m5Hx7ZtiZkP/SM08FOE3Gv26s=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RVMU+S0hVvFpjz50NlDw3lhcwDLe5as0CabJyBBg0C85PL+AjHKG8b9tmmTEPz2MF
	 a+uYFQjXExHYmRTgutUUMtAZFyRDodQt93EAJEdzACE31/Hz06O7SYyzooStFCP3is
	 8BDg9p9B+2HWLAvKSlRdRA44JZwM5XzmN75ceZ+V6bmEGE9ewlQcz/XMOL02N5UwY+
	 b1/GvJsimhrWONfDcTIS3qPYNTq/xJpyiYkMsGkbx9aopoZQip+GAMfA8atlm+BHeU
	 0XpvhOD7CTDtkkLo0KcFDEaE0+Mn7ZIZ1YVkApIVMpAZGcdZ1Ex4y5qkAXBKFNWn36
	 Ahftqvwb4qnAA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.3;
 helo=out30-3.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=ku1OtVd9; dkim-atps=neutral
Received: from out30-3.freemail.mail.aliyun.com
 (out30-3.freemail.mail.aliyun.com [115.124.30.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdNqh4fHzzDqvp
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 17:31:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1605940300; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=RhYlWONqFdrEOlZjwIPvn2Nqs1/L6xdP66OoDCsbxm0=;
 b=ku1OtVd9VsxUwl5/61DE/Owio7byC8prLW3IXMSNbP1Q94VwGvI28RS/XNdwS/PW9sN9AZfY5zzqcsRGHsVwSQyQb+LoNCbyk54yNh1MlzAmEof+SaYP+hzIAwks6gsv/WWQdQaFPmULs2rkEqiUMqvX2PyJCu0GzSSvcYsJNBo=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1193961|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.00402405-0.000625928-0.99535; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01e04407; MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=2; RT=2; SR=0;
 TI=SMTPD_---0UG1k9QS_1605940298; 
Received: from 192.168.3.30(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UG1k9QS_1605940298) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 21 Nov 2020 14:31:38 +0800
Subject: Re: [PATCH 1/2] erofs-utils: drop known issue in README
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201116125527.3644-1-hsiangkao.ref@aol.com>
 <20201116125527.3644-1-hsiangkao@aol.com>
Message-ID: <b2d63c9c-3da1-c766-b037-3461ecf8d288@aliyun.com>
Date: Sat, 21 Nov 2020 14:31:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116125527.3644-1-hsiangkao@aol.com>
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



On 2020/11/16 20:55, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Since lz4-1.9.3 has been released,
> https://github.com/lz4/lz4/releases/tag/v1.9.3
> 
> Move this lz4hc issue (lz4 <= 1.8.2) to "Comments" instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
