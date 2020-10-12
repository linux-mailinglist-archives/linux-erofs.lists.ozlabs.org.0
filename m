Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201328BBB6
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Oct 2020 17:21:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C92TW4lkYzDqkK
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Oct 2020 02:21:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602516111;
	bh=JKhTAO4e3CgZcFHsY6AATvcjmc7diWxcRa4xJpfobeY=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=g2bYZmidnrtS9Y7sGAY5f6QYnkkJMkRveqYs08pLanYJ/P08X+fHSS/hsyz2+PhpB
	 lO+VPcAgqMB/HfE0for2WmNupRuSz99qrjb7ezG4ICg91Xeiqz5XpoF19jzJZ8/s5A
	 g4JxNwAq+iRBCfZ2J5v2PIt2Gwkk+PhnGrH4/i2DRux3twb8EyWu2oAIHvsiW7SSv/
	 A9q4AsbfZK2ACUc3MqrjMbANu92MvoQDK7u/d9EMY4H0PyJLu3c1SC4Wu15TryIH/k
	 DIBajRNRBGMPHb70EpQmmw+DluxawPk53N9T9DkhHPCV5RRCkYmY80pYpTQVGo48tP
	 fh1vYe0qtCGyw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.29;
 helo=out30-29.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=ov6RbNLF; dkim-atps=neutral
Received: from out30-29.freemail.mail.aliyun.com
 (out30-29.freemail.mail.aliyun.com [115.124.30.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C92TN1hP9zDqjn
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Oct 2020 02:21:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1602516090; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=qdEtJmaF1vr8K5kj+WVpy1YJMg40lfnkL48ua0ftM7Y=;
 b=ov6RbNLFgHoi/yGaN1zjxlq9U9B1y0K/3/iJcaTxRGPDzDJYyie1hFe29eUKqDCFbJ784PVtLvNDauBpxlH3iMVy4dRBJPU5t2i02mtz+Y6eAyWzERAjMnC7qd4Efxd/yUl5k3aUq1nMITDcw2tFzXz2k6a4MT4X4MnUqkeyJBY=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1426594|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0202992-0.00336022-0.976341;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UBrEMdz_1602516089; 
Received: from 192.168.3.5(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UBrEMdz_1602516089) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 12 Oct 2020 23:21:29 +0800
Subject: Re: [PATCH] erofs-utils: README: update known-issue status of lz4hc
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201012073446.18103-1-hsiangkao.ref@aol.com>
 <20201012073446.18103-1-hsiangkao@aol.com>
Message-ID: <fefc27c6-ba56-4134-dc8d-5e12a01a783f@aliyun.com>
Date: Mon, 12 Oct 2020 23:21:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201012073446.18103-1-hsiangkao@aol.com>
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



On 2020/10/12 15:34, Gao Xiang wrote:
> Known issue of LZ4_compress_HC_destSize() mentioned in README
> was targeted by lz4 upstream days ago.
> 
> Update README so all users can be noticed.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

It looks good thanks
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
