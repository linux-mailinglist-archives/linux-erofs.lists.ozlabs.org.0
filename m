Return-Path: <linux-erofs+bounces-1034-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92AB5918C
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Sep 2025 11:02:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQwrY5dJLz30T8;
	Tue, 16 Sep 2025 19:02:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758013325;
	cv=none; b=R9OgcMdrjHBuPH+SRVvrEnkAaF3x70/FEeHPh8AglYlFd25FzeNeEOmfUxA2mGDYR204nl+Su2eJOGFHz3pIlJjbcnBK0cnat9QEDOt9alzKEeUOObQP0FNA0l9lh/9BPuu4jDczJ64DBwRU44cRa+1esPLsOLEecLC0u46Rhhsl+hOGIxFz5TPs6XlCz/6RC1LTGUfTGYJa0pKZDkN7Y7Gq6G3NRcrf3sBfFHKo8IjwQh0wg0MI6txiqmeB5ETSWh90NruZL1yfElt2a09PUub5rQ39u63JpmViZk3DgWdARyY08bARc9ys7h9snYmWdKgggL86a16YPZBWAHqOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758013325; c=relaxed/relaxed;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DIl5IfLKIR47oEghEwy4F6LQPtbwyQsJvUfavzo5u4emaBdBC2jTCiDTHBh65qG09/hFpaOFXPjfccymeX5LR9WEqktwMKUa/CuW/NqRzPRmAzweq5Ck0lMdVvtFzxL/jHf46aRSn/6j02RgpMhDJ0b2ympxItFv5BwtnfQBcWhUo697cwSrvGI2TfuAzGk9eQNMnIBOTFKmsyCLYO2j/RQ+mhUSCyEBLYbt7ldYrBeSgWevs2CN2ViutZpVjos6uxn98i9YQp+/FXwmcflIQPaRRrZT6OPEVEKSqmLvr1ay1aS7h0ahKSPIl3S0fwd9i/SezHW3J1dYnSTjSuwceQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UEm9oUBA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UEm9oUBA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQwrW5tTPz304h
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 19:02:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758013318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=UEm9oUBAw1Q1ojARoomaV3YRtV0JjL6chga9n6pVqO2Uu7qx+pKGvzoL57EJ1RsxnIqNhy1G1J8/jCFL0OQj36jPhCiUiX0Nl7g40oR2Wq36cXYN6G7ZA3zkmVOWwh38QiJe1tJwKz6U+jufzPR8BtHqlHKBluFYXyEwOFLMLpw=
Received: from 30.221.130.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wo851Ss_1758013315 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 17:01:55 +0800
Message-ID: <e0650e39-f555-4fe3-8c80-cddc6414a449@linux.alibaba.com>
Date: Tue, 16 Sep 2025 17:01:54 +0800
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
Subject: Re: [syzbot] [erofs?] INFO: task hung in erofs_bread
To: syzbot <syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

