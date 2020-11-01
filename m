Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBAC2A1ED0
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Nov 2020 15:55:56 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPJyK5f6RzDqYY
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 01:55:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604242553;
	bh=TnrO4P1lTUzfslOBi23CuUSvBUIlUsjcjqgb0ELh0aE=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Ew1SqEQ1cA3UBOqmDkvqenfMymdQem5bm4fWMryTsWCQJFqYXUuRbbSYksBS+T5X5
	 0mrZgM2PMBWiKfbIQNlk64msBOZtPGEh/CmMvQR+kjZNauDV2rpUAOzGT2grCBwlZk
	 Kd0FZpNljIQeKD9Bp4pLPk/izygO6XFb9xdET/dp7ygiAY/Tn4g8/Ynn10vqtb9fPq
	 Lai7v3uAB51CNEkdjwUvqglWVHsxG8l93vy3kn6LAx1v6oAMa5zkcHhY0SQIDn7KRw
	 HgpzPkN7gRjY8yN5uogZJBqPvStZqGl5laFu2jlOX2t3B2HuuqyCYpdnq5SO7MNKVy
	 10gzorc1Cd79Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.16;
 helo=out30-16.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=WVjXAX/2; dkim-atps=neutral
Received: from out30-16.freemail.mail.aliyun.com
 (out30-16.freemail.mail.aliyun.com [115.124.30.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPJyD2D1GzDqNt
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Nov 2020 01:55:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1604242539; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=/GhY1EXYhRaBSbi0kEEUA0KUr1Ls5HiFicRgvsU0HRY=;
 b=WVjXAX/2wgEAw8kDS2fFxX/HgcCzE/CWNCWjKAwfSOnKk6rsfBqAT3yqc955K9VFTploxSEjOnI+GWndGPP65tEJ1Fe1/T/fI7mIb/536N9v2jyV3uug3nArY15YiND9/52H27j3dci42SXTt+XyPm2qlct9Pws+i5/JgF4sZR4=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1144247|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.0228218-0.00232356-0.974855; FP=0|0|0|0|0|-1|-1|-1;
 HT=alimailimapcm10staff010182156082; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UDpoubx_1604242537; 
Received: from 192.168.3.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UDpoubx_1604242537) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 01 Nov 2020 22:55:37 +0800
Subject: Re: [PATCH 4/4] mkfs: add option to use a pre-defined UUID
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20201030123020.133084-1-hsiangkao@redhat.com>
 <20201030123020.133084-4-hsiangkao@redhat.com>
Message-ID: <f72a6b1a-0af7-466a-a7ed-e2031cbb5ef3@aliyun.com>
Date: Sun, 1 Nov 2020 22:55:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201030123020.133084-4-hsiangkao@redhat.com>
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



On 2020/10/30 20:30, Gao Xiang wrote:
> Usage: mkfs.erofs -U<uuid> <imagefile> <srcdir>
> 
> The filesystem UUID can now be optionally specified during filesystem
> creation. The default behavior is still to generate a random UUID.
> 
> This is useful for reproducible builds.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
