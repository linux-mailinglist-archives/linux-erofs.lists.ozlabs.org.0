Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B2311D8E
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Feb 2021 15:05:01 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DXvDn5zxKzDvZC
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Feb 2021 01:04:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612620297;
	bh=ZRJ0auwkcfGgiru6qLRWi+bc58GtfJV2/u+CYYkDVPs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oLru9tukJt4PEhWVFtxyM7/jcNlyehdVv29AnjpxGXQW8v4v4pUCvTza9nF8tX8Cf
	 2rEdLKnaNH487UYly2QcwCl8AhOJExUwB2U0E+BzypXPi4WsC2IcI4kjgUFhnsIoSh
	 6/iD3eomr7b/8lkemyI9hu8PPWGtDB4rZOqx/TQ8FBea/yN/wI6Al5ytibWGH7R/xn
	 eFH4tQBLLpyCpb/LLIC2Cyz6Gmq2i1O1GNga2nBpg7wGWNiqp9d5bzgOc/WbCRtyT7
	 yNm8jNdkuargmZNBIhjiVLxyHIDNhBxYxXH9QD3qudAU2k9hqpQj5w7epHE1Wsnd15
	 3qpAfIyEf0xAg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.39;
 helo=out30-39.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=GOYjtFcN; dkim-atps=neutral
Received: from out30-39.freemail.mail.aliyun.com
 (out30-39.freemail.mail.aliyun.com [115.124.30.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DXvDX42jWzDvZC
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Feb 2021 01:04:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1612620267; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=HI3HQa1SAaX3Cv8r+JPShWIqDme0w4qtsIFNwDYoAb4=;
 b=GOYjtFcN+11DtMQutCrPtykSTO0Bgmmcho+Tzx9YXpdw0qnwqNIn5jZxDrioBSjvX1JfZ6o/wFckpkgRL0UQqzo17S0RnP3lROxj8XTrbgdpGtdic02t6gJO2CABw2fJFzTwN/52jp5hKcY1JDB4MJZL8ng02X8b3JLEQ7bJxUM=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2854939|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0276019-0.00121955-0.971179;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01424; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UO04YLA_1612620266; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UO04YLA_1612620266) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 06 Feb 2021 22:04:27 +0800
Subject: Re: [PATCH v3] erofs-utils: fix memory leak when erofs_fill_inode()
 fails
To: Hu Weiwen <sehuww@mail.scut.edu.cn>, hsiangkao@redhat.com
References: <20210119153620.GA2601261@xiangao.remote.csb>
 <20210121162101.7093-1-sehuww@mail.scut.edu.cn>
Message-ID: <cc084e55-3107-5439-9869-d6f7eaff2dd7@aliyun.com>
Date: Sat, 6 Feb 2021 22:04:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121162101.7093-1-sehuww@mail.scut.edu.cn>
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



On 2021/1/22 0:21, Hu Weiwen wrote:
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> ---
>  lib/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
