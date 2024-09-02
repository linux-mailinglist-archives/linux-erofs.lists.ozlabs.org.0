Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A59683C5
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 11:54:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy3y23Vc9z2yMk
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 19:54:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725270872;
	cv=none; b=TPa5NVAD7hqSlMirdHNaOxjFv5o0Jg88SC8dGJg4w1X0qW0JrWdTMyJm0JyQ3wj0uEOQCLHqYf+R/hpnEYIMeMtwY8bNuNYHW8kxZZLZKPAaRmYEF8ln/IRHzY0BO8TmWUqtJAVvx6dyI0RSUoRIY1u+YrOB8/H6No155E+29BYJo/aDX9Eozi4wo5F3YgbzrrADPZ5zvfi3Br5B6B4I/Mw91cAllgGBGpOUR1KiFJjd1Rs6W1Bk49TjMMSN1wN3xckUYgHGk0yIqmeTpypfqFckDzBjYSMeEqc1W20jTCCLPOJyPiwyVGlEvcIPKEyETZC+LoRhrLqqHIZUTbmB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725270872; c=relaxed/relaxed;
	bh=jiZDkhirvnlhDcFjuWk5Xh33CaRuy8xC7OmjieMbApw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIvP7J+8qRECn8qVz99+7i5IkkO//CvUU3HOs/WgW03J9zHHbtXuVVX/Z3AXv6EpQC5lMPNCXngLIwCmb+egQ1OLZZucxMDx2nP5sUylKoHOuMCXI8QXIv+0Qo0QC73w6eG6ZaLcznU/jXNqTAsReD5dHQORtqaBvVyZpSq7RL21ht3k1fua10/K1PsRWpV/NCS31dangoPi/H4lYyw/0mo0X+2tnQvXyrGpYZcl1nStbQMgbJBWBg2QULJFsukyQoPX+DFiqhp1bFeltXW/gQD4kS216PVovMX0bnQ7lLTHI9EP5HaBfEgVvdKM05o2JKBVVFAV8HbjMhhbgqPOtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wrxvzcc7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wrxvzcc7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy3xz1H6mz2xgv
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 19:54:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725270864; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jiZDkhirvnlhDcFjuWk5Xh33CaRuy8xC7OmjieMbApw=;
	b=wrxvzcc7KkMh3CDKu3ObgnfRNaNrhqwOOxNqNhJuFCsDspOy81M9CKpFPWUdSuNr7M03QfG+oMF0iS6oJLTGKHZscKdvXeXdcZnybDW1lFWRFzFjl9mXkxKrmtHsXCuBv8v6MP38MOcspE/vrc5IQX4PXEiiCoM9RLtcpdbsyuk=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE7.M8A_1725270863)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 17:54:24 +0800
Message-ID: <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
Date: Mon, 2 Sep 2024 17:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
 <20240902093412.509083-1-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902093412.509083-1-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/2 17:34, Yiyang Wu wrote:
> Refactor out the iop binding behavior out of the erofs_fill_symlink
> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> can only deal with inode operation bindings and can be decoupled from
> metabuf operations. This results in better calling conventions.
> 
> Note that after this patch, we do not need erofs_buf and ofs as
> parameters any more when calling erofs_read_inode as
> all the data operations are now included in itself.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
