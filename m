Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3379D03D5
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2024 13:32:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XrqsP0hMxz3bgV
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2024 23:32:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731846759;
	cv=none; b=aE9oEHcNkhwpBepdr87kEcjXUjFw0FUk15VAoNeGP27Tux1tHEJNxhptPzGJiL6EglZUFfboWyqa1c1HfFPDISfnpVy8u6xwtv6VyOEiEwmAiBjkgyy4Gm5y5R3vHbV6McTn0zQjpMmvXk5VkFN55dk8DneCqEaYL2BOTCYq17oHK7kLRTM/5snj48KCrV7rqBQbKKxH45rmiD0ynye9/kayvksCPln3E3jvvKiR7slo96CEZFrAG+ukdMc03AIJuC7benp0NntA6HyWmpLWwJBAfgbDH15XjGDkAjbTo+OFldwyJz823WMB8ZwBEUu+xlZLP8zOI1zfMOqDTm/FlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731846759; c=relaxed/relaxed;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Be3hUE6tNfhwn/TL7cBBgpRmVFhDrkKoxTRDqywxIwB+A/iYWsEX0S7zmGdi49jExa04WtkMDBpbZA7eGxd1tX3zie2c/P3c/6tN1zFbzLJlv/DGp2qN9QhEzk5TF72YS1CrOlD9WsTKeWPUc8nANXJVMkBmE72n0RBsADoDdF5N1uahWXr5U7ILzu0Sysyyt6qDv17dgnbyPTZsOJnzX9ikXRzPKG8AB56UxlBequXwlNqbbcu638s6N0z2Pp+xQGmfsPMfCg1ZRCdEeqd4trKXYDfQlLowrNm3JQdU0xHk8mZrx0n6k73ZJobjAtV2QwLYYygdN6jrFis6JJk6Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hAC2Jqul; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hAC2Jqul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XrqsC5Lfrz2yyJ
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Nov 2024 23:32:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731846741; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=hAC2JqulEL/DVmFCf9bAnhr+MziaADvTdkhO/wUlYststZ9I/GfkwfVxOJrI+/ENGFdYjdg71qYiRGx38F+zoU5mI7WKuKuWWO8pMNeKXaSg5FlkBPpCvFYtod7YE8kS7SI8rruhysYAiMJiobsFmNsZDFZs/M6v3q3NNxJ3ybA=
Received: from 30.27.77.84(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJZQd4p_1731846737 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 Nov 2024 20:32:19 +0800
Message-ID: <79b938a8-ecb9-4d3a-b1a3-76f1a9c9f351@linux.alibaba.com>
Date: Sun, 17 Nov 2024 20:32:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
To: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <67373c0c.050a0220.2a2fcc.0079.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <67373c0c.050a0220.2a2fcc.0079.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
