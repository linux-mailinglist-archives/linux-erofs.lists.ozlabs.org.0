Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DFB327272
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Feb 2021 14:22:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DpPFd6d2Pz3cMZ
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Mar 2021 00:22:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614518549;
	bh=CANgBI0iQGmGZswRc6l8hNOUBnubpbAMzIye9xT5HDA=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CZuT5MhtkM1a0BLkENN+UuzaxfG7uCHM/O+JSAi2FQbWEo5y49/N7dk3bmsZG7qyH
	 FHIk+TPazWhGpyxt1ZoV9jH1fPADSktziOWpHGRO9x9Fb0JqQhJEJo7OwT3GVfy9+0
	 nkEnPODcavl/GLb566L91DZ/a3XZOQEMH3ya79aytpCVA4bhHStsD8XxBaTfgauE8X
	 Ps+9oVW+IboD28mWOvSdZ2f/vpiZm2mSuvWzSSlxcmR0HgUJV74jVcqaaNhDNA2fbC
	 JWF3kCOKlNIawP/UOyBEJN1kn2wxmuwLFvlSMoJyrDUGyz7fMlOiCJqaw1Gp+UnVBM
	 U/IKMIG+UzGkw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.50;
 helo=out30-50.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=A+5NkGNB; dkim-atps=neutral
Received: from out30-50.freemail.mail.aliyun.com
 (out30-50.freemail.mail.aliyun.com [115.124.30.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DpPFW6bXCz30MG
 for <linux-erofs@lists.ozlabs.org>; Mon,  1 Mar 2021 00:22:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2332219|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0261376-0.0016182-0.972244;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UPojKlo_1614518519; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UPojKlo_1614518519) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 28 Feb 2021 21:21:59 +0800
Subject: Re: [PATCH v2 2/2] erofs-utils: more sanity check for buffer
 allocation optimization
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20210214153549.2454-1-hsiangkao@aol.com>
 <20210214153549.2454-2-hsiangkao@aol.com>
Message-ID: <901a00d5-c181-79d9-66ff-fff6146a317e@aliyun.com>
Date: Sun, 28 Feb 2021 21:21:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210214153549.2454-2-hsiangkao@aol.com>
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



On 2021/2/14 23:35, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> In case that new buffer allocation optimization logic is
> potentially broken.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
