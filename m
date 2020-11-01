Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A02A1E8B
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Nov 2020 15:36:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPJX43zV4zDqY7
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 01:36:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604241396;
	bh=rDik0BJgLXnR/nm4avs+sjdqpYChCMpTMFQo6Gh5ZoE=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=DEqScJdJFac0JPhvIgBszcu2sHvT9wuydpVdzVY+NcLdmrl7Y4zkDNhG912ZsOM+G
	 QTz3t+4Fl/grlbW9ZLcnOW7k01OZINjcUDwNRZp9aL5D3wRacyjJCPFmlTjwhVKl8/
	 mQw3f4NDnXd3q+b5D0DL5xabyk665/t5qNZ7w1l6NIirj5VgGIGYd48xOlyPgIr7Lo
	 vWmJm2mAHISw7O8l2l/9sMGsvvi5Mcad7AiTpyhyz26eiP42O8v3JGK1VuGe5LMyOe
	 Qj4vmnH8xg2nUNYblGcc4y2mumJhwICzyPLZJhKzHu0FMSn/9vuokmfhsQG38etiVx
	 3e+yFAIatTycw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=DqTT83ch; dkim-atps=neutral
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPJWx1GD5zDqXR
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Nov 2020 01:36:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1604241361; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=GTZ1HWOY+twzog1s2uEp4fYeR0WHj/Ln5koZQ9BEBOs=;
 b=DqTT83chJRzN3BG05lK8JoK5rMbStWgyOg/oY24BYEymcYx6o6LFhskUWvx4T59J8pCaBP9qF5gdz5RRcY3JHFQiVo3zAJ7vSRiBYEB3sgBm2UTwd2PO5OAHcPOVz98tSPbyTIIt9JKtxUdcyHj2rxkcxQutFWH2niigENzgrek=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1090529|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0019872-0.000163998-0.997849;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04394; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UDpU0oL_1604241360; 
Received: from 192.168.3.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UDpU0oL_1604241360) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 01 Nov 2020 22:36:00 +0800
Subject: Re: [PATCH 1/4] erofs-utils: fix build error without lz4 library
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20201030123020.133084-1-hsiangkao@redhat.com>
Message-ID: <282ad807-52bc-deb2-4293-97207a56b0de@aliyun.com>
Date: Sun, 1 Nov 2020 22:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201030123020.133084-1-hsiangkao@redhat.com>
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
> This fixes a recent build error if lz4 library doesn't install,
> 
> /bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -Werror -I../include -g -O2   -o mkfs.erofs mkfs_erofs-main.o -luuid  ../lib/liberofs.la  -llz4
> libtool: link: gcc -Wall -Werror -I../include -g -O2 -o mkfs.erofs mkfs_erofs-main.o  -luuid ../lib/.libs/liberofs.a -llz4
> /usr/bin/ld: cannot find -llz4
> 
> Fixes: c497d89e5eac ("erofs-utils: enhance static linking for lz4 1.8.x")
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
