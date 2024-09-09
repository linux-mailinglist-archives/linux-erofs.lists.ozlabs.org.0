Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32F970BE2
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 04:37:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X29wq08wHz2yMF
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 12:37:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725849465;
	cv=none; b=kqUvp2kbAaikSFCo03pYI98L3lNkqNauzzf4TnYuDMr1cf5Uk8AqnwVV0s5v2TmZ+ePfpLnQ7/bUOoiq+rxv84QoWW+X16Z+rTvx5+8vFDVukvtUMS8TTtUbmZpYqhpccTyKUsfC9YRVaWBX4+zDmHl3m7snmSk+mNwWvtldDDQ+d2WG+FenM0oV5S01lTfbx6zdj26/JiYq28rPWNlkDqeAbE5i8cwx1wUh+6uh0nT+gKHNnmmVml+DcRn+XtTWkEcTahq0GKUC5FVRh8q9DnTO639/DHzshEkBtdfIF2nT6HRZqoc6IkHBOF+MCgZ6viWC8VJZWhf5LnsfXqlsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725849465; c=relaxed/relaxed;
	bh=euI2G4wjW/uK4MBJgA0dtsOY2vg04Pc1/WMCn0Xhk/c=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=XuNKRknXaFvBB/qQDuBhLrnvlBgWWs+EeC89eO3dnGC0W/EglzKeK7GmG7ZwrEncMpfQ0ZTBSxFEGWCppuikoEjXsFD/MHHnpWezKo1Ot2O4fI9+3DPBRdM/O6/udyW9R5nuar8GN/Fa6+g3LRzh5+lLjSynNt+Z1qpSzfFYOgxflC5EfjMfDWonFS4t8+fvmqQCgeNQuuP2AUY56/JIGYO/aX+I2c0khKBiJiZmr3Qu+xTjYNJ+wm5ifZDdIackOTuzrGUn/5oZBfws38UmtEIsk22q40es2Jk6nG8EhOgKqZi27OPciWyVezZU9DiUR2KhsvtWpvDRPsSktnc+2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PTVahqAt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PTVahqAt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X29wm21rkz2xs1
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 12:37:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725849459; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=euI2G4wjW/uK4MBJgA0dtsOY2vg04Pc1/WMCn0Xhk/c=;
	b=PTVahqAtZzNwAaAVaplpIOQAWWkOLbRWM9zo+OxD9w5b3slzQA+N7g1FC+V0u1heKuJ8ilLsqzkFm9GvamLLEVSNUPGnN6iueMD4d8Yfiicek++b52lmOk34Zp7YooZFFXH4ro/HTH7Q6W46CIG40QjkjwXS7zuvQGZg1iesS3s=
Received: from 30.221.130.133(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEW772T_1725849457)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 10:37:37 +0800
Message-ID: <fa6f1972-aa03-47e9-8984-50b57bbf9500@linux.alibaba.com>
Date: Mon, 9 Sep 2024 10:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix incorrect symlink detection in fast symlink
To: linux-erofs@lists.ozlabs.org
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>, Colin Walters <walters@verbum.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/9 10:28, Gao Xiang wrote:
> Fast symlink can be used if the on-disk symlink data is stored
> in the same block as the on-disk inode, so we don’t need to trigger
> another I/O for symlink data.  However, correctly fs correction could be
> reported _incorrectly_ if inode xattrs are too large.
> 
> In fact, these should be valid images although they cannot be handled as
> fast symlinks.
> 
> Many thanks to Colin for reporting this!
> 
> Reported-by: Colin Walters <walters@verbum.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Fixes: 431339ba9042 ("staging: erofs: add inode operations")

Thanks,
Gao Xiang
