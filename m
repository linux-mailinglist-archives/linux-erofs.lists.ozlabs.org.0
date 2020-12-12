Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB62D856C
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Dec 2020 10:54:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CtNL31pYwzDqpr
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Dec 2020 20:54:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607766891;
	bh=88eC0kQIQeE+LOodynLYoD7TNifPlzMv1Cr7cSRdbo0=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fmOO3oep4107iS2onPU1wJKZCJWqdBZ+Y9DJBel+yOmiTVLhtLl9mMYwLAhvxocqW
	 IgZtm8yLguW9mQor70LyHUd9O24/rkMSqhJCbqv3fNEnQ/G01mLZxJE2MapVdRUnSl
	 d9NqJovimkpXiUteXwUWWAo6nkHAsiT50Ns2dq6iad/tnkEXBsUxKJrhfFXurO+vh2
	 CZLkETUGFQHqxSOPFMRkxzp4z2vr01p0pfdNWYB1eXXsEC/0ePYpYZZ3st8XPeHTsk
	 vU1nnXwMyUAhz5Y3xnpNLymV7mWYH8vHN6J8l/6AVH/CzF/Xs4mH74RlN+hA0J0bLq
	 VWQJRsN4MqrLQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.15;
 helo=out30-15.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=Vw+0KFwJ; dkim-atps=neutral
Received: from out30-15.freemail.mail.aliyun.com
 (out30-15.freemail.mail.aliyun.com [115.124.30.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CtNKt5w8fzDqn5
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Dec 2020 20:54:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607766868; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=88eC0kQIQeE+LOodynLYoD7TNifPlzMv1Cr7cSRdbo0=;
 b=Vw+0KFwJejmxPGdTGRwWoaU6cONYvc1uTtXmzHxyVKWwt63GjnopDGRFv5c6LLsf6MDeEgrW5BTV3GNf6jEFOcCEG5n2PTK9QTtsDvRcHMYt1vt32DPPJFb3nbxtcwnZvDxQm6bKTW8lRi71PzPxmSEq68anqhIYIcyJDSuIdr4=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1130351|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.00529028-0.000260325-0.994449; FP=0|0|0|0|0|-1|-1|-1;
 HT=alimailimapcm10staff010182156082; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UIJsc5y_1607766865; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UIJsc5y_1607766865) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 12 Dec 2020 17:54:26 +0800
Subject: Re: [PATCH] erofs-utils: fix multiple definition of `sbi'
To: Gao Xiang <hsiangkao@redhat.com>, nl6720 <nl6720@gmail.com>
References: <20201208105741.9614-1-hsiangkao.ref@aol.com>
 <20201208105741.9614-1-hsiangkao@aol.com> <29768659.UDeB2voVRW@walnut>
 <20201208232407.GA3257594@xiangao.remote.csb>
Message-ID: <535fc06f-ad3b-1712-1b1c-2d3c6fda0780@aliyun.com>
Date: Sat, 12 Dec 2020 17:54:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208232407.GA3257594@xiangao.remote.csb>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/12/9 7:24, Gao Xiang wrote:
> On Tue, Dec 08, 2020 at 06:16:57PM +0200, nl6720 wrote:
>> On Tuesday, 8 December 2020 12:57:41 EET Gao Xiang wrote:
>>> As nl6720 reported [1], lib/inode.o (mkfs) and lib/super.o (erofsfuse)
>>> could be compiled together by some options. Fix it now.
>>>
>>> [1] https://lore.kernel.org/r/10789285.Na0ui7I3VY@walnut
>>> Reported-by: nl6720 <nl6720@gmail.com>
>>> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
>>> ---

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
