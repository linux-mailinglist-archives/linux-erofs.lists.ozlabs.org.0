Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B3E89AE0C
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Apr 2024 04:28:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DWms2gKL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VBx3G31NSz3dVJ
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Apr 2024 12:28:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DWms2gKL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VBx364sR9z3brC
	for <linux-erofs@lists.ozlabs.org>; Sun,  7 Apr 2024 12:27:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712456876; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TpGu6bfKPibDtsJJ5+poBJeszAYT9t0y5wsf06zgVao=;
	b=DWms2gKL+YmSUQxXn6AVIlrjaccimZDaG6Fe0lvEltTkqQJQunavjW0WI0Etq8O83Is/cqhYEnylq/Iz2vO9cyfR1uyFz2svAyo7KVwG42NMtJuamnnNhPuPlRbFq1Fl3SgZ6z1fftgRxZpjFavtEqbLUDbS6j3vMiRvRpflkMQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W4-lqni_1712456872;
Received: from 30.97.48.157(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4-lqni_1712456872)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 10:27:53 +0800
Message-ID: <e3f49943-722a-40f5-a099-117d5b3e5922@linux.alibaba.com>
Date: Sun, 7 Apr 2024 10:27:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOaCqOWlve+8jOaIkeWcqDIwMjTlubTnnIvliLDkuobnpL7ljLo=?=
 =?UTF-8?B?55qE5byA5rqQ6aG555uu?=
To: =?UTF-8?B?5a2f56Wl5a6H?= <1156140554@qq.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
References: <tencent_75345952C247D3E1F26BC00629354C648A08@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_75345952C247D3E1F26BC00629354C648A08@qq.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/4/6 10:03, 孟祥宇 via Linux-erofs wrote:
> 您好，感谢您百忙之中阅读这份邮件
> 我想咨询下社区有没有QQ群或者VX群呀，我对这个项目很感兴趣，想试着做点贡献。
> 祝好

Thanks for your interest.

We don't have any IM groups for new developers (I'm not sure if
there is a need to have a matrix channel though.)  EROFS mailing
list is always preferred for technical discussions.

If you're interested in EROFS OSPP 2024 [1] this year, you
could just check the latest published EROFS subprojects later
this month.

If you'd like to learn more about EROFS itself, visit the
webpages [2] and read into the kernel/userspace code.

Hopefully it helps.

[1] https://summer-ospp.ac.cn/org/orgdetail/192db666-dfa0-46d9-9f58-9d8d165e2914
[2] https://erofs.docs.kernel.org


Thanks,
Gao Xiang
