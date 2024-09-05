Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB696CCDF
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 04:58:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzkZW5QKGz2ysf
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 12:58:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725505106;
	cv=none; b=VozrgZnR5EKTY6lnvwrpkwW2NZg+0QJyZLqUuDrbjr/m2NVxxJSwktkUnPnd0DFTeNdal+CD0C2zTK1dSAxqW0Ynghq9a5GygQZHV71U0PvIHdiDCD/jWi7alt/Jwtz7AN0X/I7coV3XD3UXS6wBGQ7NUkbyBRwqJ2NGbTPXHaAFNF1nFmLbY6J25vpyQtjW8P0svICobKxYA1oW8J8nZFjMskWu0Hf8IVDG/WkQ1XZxNLXz7aBAVXONAgS+huBJ5PcArHzQU5EnPen0DjB0eFdYOo5CchrgwXw8rTr3RqvKFUAxWVZ2z5HN3qoFzeTdYXrKxmqkv+AsZf6Ied7nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725505106; c=relaxed/relaxed;
	bh=0vcnJvpd/gY/DR/ExUFwhFp+YngaXKdK9YOU7JWWiOk=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type; b=EchOX439QUV3a0xs7n1IYHEhnoi/MbMQBTMEb7kAnzL7sQeATl2imEaBumfDPKDW7KZLnNMWj0YICKkYUZDZgU/JbAwIp9H/V+Svon571LySciYTtVBYX8TgZJhVIPFMh7NDbcAJyK8RvKOhT2r9geWqmjMrROc0EGdBsTBxNiakYyswyYXxn1HAYXYfHKnw0nz8GggeoOZ6VloU2f3SgB/S3v2i8tAY1YnngXGV8As4TRPnsCsLfynXhVQFmdtQijj/hBKjtgC7d+ZuD95XbpQINa2RLqGvErKIcpVl/x3/m3/o0x5VXKmdENRaZjJK10FvngFbD+i0QCYFZ4znpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uwHiG0q6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uwHiG0q6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzkZT4Z1jz2xq0
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 12:58:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505102; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=0vcnJvpd/gY/DR/ExUFwhFp+YngaXKdK9YOU7JWWiOk=;
	b=uwHiG0q68QhXOALBZlWGf5XRyXs8Pavs2Eym/XRSI07V/TDixXLD+Gd7IhsoPz4DnSOSv1Gf4D2epFcz7FoOxHxEi+0mkfY46SrtBplLIjeHJFuIFoW+Mlfbl1OmG1SiPRnUx/oN6GbhAkqmyyNz21b7Aj0KuEsDrR8WqYAz2fI=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJYt6K_1725505100)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 10:58:20 +0800
Message-ID: <80045cd0-338d-43c5-bea7-378504032006@linux.alibaba.com>
Date: Thu, 5 Sep 2024 10:58:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
To: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <0000000000006d2b8f06204e76f8@google.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
