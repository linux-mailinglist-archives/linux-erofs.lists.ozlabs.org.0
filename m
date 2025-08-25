Return-Path: <linux-erofs+bounces-900-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4633B338D5
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 10:30:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9PBf3pGTz3cZL;
	Mon, 25 Aug 2025 18:30:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756110650;
	cv=none; b=eB8rUEwVxOSfrUfLevn4T0gbOqJK6ByYwckCmWUD/FTeTm6YnY8u+09eluj2KvgCiON2B7Pw37ZUOqp8A0gtwE/ctZoh6OBM2DSxY5RebzH/8jN213/JxpZ5EV5ERoH+ngcb8o+chfonLZb4DHMy7IYH+EYC90RscPFk9h4/7qvk4oLkc3C/X95zEuxQpQFl9DynGWCQt5o2i50s5PLQ+naM78uBg5nxgGYMyiRReKBHsF2RtkOZP0E9mDwFSXHyeWTCuogde6zLbC4uZyUkyzLqFAHTf8pEkE1A+ddSP0jnlmGNKugqDfYRQhxRKgFVHf0oeySjjk4L6hzypOxOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756110650; c=relaxed/relaxed;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=NR+nZR24OHgv2h/8ro9bJUOOABr8L7EIcGl1Fl21TYBK37r3xOS488YvvA88KzM19JneuQsIEkjbogrYLwXb+xx9+5DTomI80NkH7YHOlB0N/Z1cpwWCPInTeqqK7Qg2w5OzS9Ohj+25btIFEJd8wl3V4WIgwetR/ISt7IVndtFKDOaVFkcbTllUIo42CV48D+WNdNC+/Pq9RKFJkioIetphvg3ikpPe6O5Xa7rc9qTgVy+A1BJ2swsI/IUHfeSjsqbhzz6YyY53YXNOFSs499PGY+YK/ud+LQlKHiLnO9sNHqvBc1UcWBY31nC6TAX3sH05gxeNy8JsY2rh2RvAyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KEIJ8Yw9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KEIJ8Yw9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9PBc1M19z3cZH
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 18:30:46 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756110642; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=KEIJ8Yw9GOx+CtzWlv/J9+LW9SoXlxuN78L97E23X+uOtxdyN+LLErTJvvWxnP+PG86apizM0qM2eusU94jsuhi2mt1wd5suaOEF6DnEF0cXxt6RXqIaMlWUP7i8zo04gqDTBlS3WPyJtKFmC7EnQGJ7lUKv+X9CmT97pJCCZ0U=
Received: from 30.221.128.208(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmT1xUq_1756110640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 16:30:41 +0800
Message-ID: <1ebebfcf-99f7-420d-be00-606204aeee29@linux.alibaba.com>
Date: Mon, 25 Aug 2025 16:30:40 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in
 z_erofs_decompress_queue
To: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

