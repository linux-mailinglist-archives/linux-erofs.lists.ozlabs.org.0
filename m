Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 940602CFAA8
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 09:42:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp33s6TJPzDqWH
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 19:42:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607157753;
	bh=km+sbYO4Z/ySqgkpWLqEAu5fimRYfF87bYpHt3+O9ps=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Qy0tkXHVXnlUQf6PmGmGJ1KsJNHoESppvcRP9kj7qduz0514UvJcMYtX3letePl5J
	 KDL4dIG9dhGpDsTLCewz6I7nahakJOiMnKIKLgxQqxIcP99j0w8w2yiNcvoV+m0AZa
	 ndpN7a9lCheOEnTQzsB3wEv+5qs2kY7ck1vEmBd3x18RNN9yfNLkJFYAeX3V/rbH1f
	 IAFCRaFOnFnV4jwEpCpUpplG7ARD0uiAD4mn/PnJ2sYaPaqz9mmS8o+L2R1OGW7Ocm
	 x0Kr/jCPLcqdV4Hb27n0gFD4cCTZwTLw7v88lF4LJvG/7UnLL9qZhTQEc/TLrYRocB
	 VbDPrSXyi2b6g==
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
 header.s=s1024 header.b=wn1iQRaN; dkim-atps=neutral
Received: from out30-15.freemail.mail.aliyun.com
 (out30-15.freemail.mail.aliyun.com [115.124.30.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp33j2qVJzDq6B
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 19:42:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607157725; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=preSmaAcNMhEV9vMEWyd3y2jDzBIf/D+r/XStNiLUiU=;
 b=wn1iQRaNsq2FXHqoBOC01L3/Q9cwOumullt+Fpl3jTC7fuIhWxyJIk5n56/FQqQxOFKFK7q5CZEgT2umlJ6fnR9xje6KUmwlT+doaNlOeHLsl804OWtmL22gfjebfErz8FdalBNyGVvvHfc/S/m21nEFHKFliGQWZaVXsyL8Kr4=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0831589|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0123251-0.00246905-0.985206;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04423; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UHZmT9M_1607157724; 
Received: from 172.168.2.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UHZmT9M_1607157724) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Dec 2020 16:42:04 +0800
Subject: Re: [PATCH v3 2/3] erofs-utils: fuse: support symlink & special inode
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201127114617.13055-1-hsiangkao@aol.com>
 <20201127114617.13055-3-hsiangkao@aol.com>
Message-ID: <5367c0d3-b303-6430-3e4b-99e2af4bdcbd@aliyun.com>
Date: Sat, 5 Dec 2020 16:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201127114617.13055-3-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/11/27 19:46, Gao Xiang via Linux-erofs wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> This patch adds symlink and special inode (e.g. block dev, char,
> socket, pipe inode) support.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  fuse/main.c | 10 ++++++++++
>  lib/namei.c | 22 ++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Tested-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
