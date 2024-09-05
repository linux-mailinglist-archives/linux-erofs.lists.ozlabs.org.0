Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B21A96CC85
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 04:19:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzjj86pKvz2yst
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 12:19:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725502745;
	cv=none; b=BdDMMEVKv1EQh72a+PSSfPNx88ZAdDYGE3ltTm6pPHXSX/BlbMtVPIMEiJ8A5Q3v/AZpIFReLep2RqhmD0XyqPEGN/X5YHlEBf5pTgE+iR9o5XZTKMSl2KA11UoMEwHrkjE2Q6AICjA8UrCTb66yBzPGFWIHKodpKqhVciTpjjKDvkkhUaHptVx0ffv5u8PUAOLrTJCwL6UJ52xCCCgxvKC3OBpZuoWza7ZbCva5VxvLX50N7tc0oyL8m8nh3BRm5nU/uiARI4AbnYdmKKDxWzpif0rcVmM01XZZC+UfTxHVW+no+NnPgRAcL/2ZrpIfjWU8yeH+qMwCfS3EienSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725502745; c=relaxed/relaxed;
	bh=oPdBIMXvvFilt1OICZGj5B5zP7g+Plj8dSvpCokCncU=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=ApKWtK2h8zr3GnVaa6orQo1EPHfcm5LwZZvibFLUtHgjWUfn2d0IIgdd3gAuBCKA3NwSWjGH+8dBSAz0kK2Saa45qSsMjuPfGaD4/l7thYythiTdlqKDxHpiTcITXyFHrEAtxqFpnELrIxxpEGC3X1+GxrcO1slUSuMtUErnt3nthBmQP7OtfTooAT31YER9FLO9t9ti0HH98m9iDi5ikt2i7ZY4IxZcwKuyKXmWmwJNEFGwXUQB+VE9BnpPU6pM0w2BZF/xe/7xM43Tdv6SpioKUqVtT8HXZqwhJDwzolXIhyKGi59tgQq3agu2TPY1PRIxLzRK21X0RU7WxjyPNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sN0oVwP2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sN0oVwP2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzjj42GzXz2xKQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 12:19:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725502737; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oPdBIMXvvFilt1OICZGj5B5zP7g+Plj8dSvpCokCncU=;
	b=sN0oVwP2HYcqFUappqODSHw8J+nJnBKdLFt8KLM2/wEESxvBNv+SQvE/p5FXa55cYw+rOqi+HQS+7Fl0VAtN/u55gKbgPyQHM1QldO7npwr+1GYqTBkARo2hM23eBa2UjwbYeS7VY/WR+2rMF4vx6ikb0cL0la7LUv1NAxZbGyg=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJRy.6_1725502735)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 10:18:56 +0800
Message-ID: <012b02d0-97ba-4d5a-86cc-2d3d36ed71b1@linux.alibaba.com>
Date: Thu, 5 Sep 2024 10:18:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
To: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <0000000000006d2b8f06204e76f8@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0000000000006d2b8f06204e76f8@google.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-next
