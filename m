Return-Path: <linux-erofs+bounces-6-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE4A4DC56
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 12:21:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6YD04DlXz3blH;
	Tue,  4 Mar 2025 22:21:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741087118;
	cv=none; b=WCYYHJ5/+pE05XzAV9iuqudI/CNCpyngUsMTEWXgQDdGcPe244AxOqkiL6+ol+FcqLFfGRCyp6vtclHa7Aq8aHMySq5nP+qkcmV3FzOi4cJpPYCPDxFzFXZmz4HWVaIpikXF+VOzNVkvOxwFfQ6kr+HA/AIMqKKXowbpq58PNTY12ViChjOrCdZASFsNtzHtDvObGb0qk+nTx592TpYf0Ww8RK654ggqZidIyUPeUyya2+FDzrZU417kV7pwsmFJ0uheFsaX31y9kq5PRLM7XydQ9oNH+dVeEG62iTSIJb8xC7TSWgbfymLPgw4BYoZNJFfqUk++5UyQDuIpV9b0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741087118; c=relaxed/relaxed;
	bh=4gSmLRbTivzjiU8XEaQKI//sTOVkf96OovK/HUTeQOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2cBdmRbbryIZMy261voJuuU9RLoEEYpEMvtoeZns4YyjZM3Xgysybr+RB7ShZfCq7NKduTYsyXlTaOHko78GxFPCqnRMXZyUC2UkbKUFqsKB5uGYp30cPhqe0o/uZmRWdlEIkfNNSvytsrpcSiC7ePxGJGwGuhH2a6s0Qh1MKX4GJllxVCsgmli0Ij+6mxr5ujhHKDlM4NAKFqWtpyZTpfoVHYnd8OxXG46ccuJFEmiEE5LN24aM3EHMThuLvFlF81jDNKi5oIDylcWYXwqul64DEiLPrij9Rc727zRN3OgnAn8RPgV7jDQ/OSRfrsK6YOLBxOp4kD6zOhBxAa8hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass (client-ip=37.230.196.243; helo=mail-gw01.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org) smtp.mailfrom=astralinux.ru
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=astralinux.ru (client-ip=37.230.196.243; helo=mail-gw01.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org)
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6Y8Y3Kz3z30Sw
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 22:18:35 +1100 (AEDT)
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 908DC25037;
	Tue,  4 Mar 2025 14:18:31 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:18:30 +0300 (MSK)
Received: from [10.177.20.114] (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z6Y8M73L9z1h0Rt;
	Tue,  4 Mar 2025 14:18:27 +0300 (MSK)
Message-ID: <108a8459-6024-4af1-978a-b085729825f7@astralinux.ru>
Date: Tue, 4 Mar 2025 14:18:26 +0300
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
Content-Language: ru
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org,
 syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,
 syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,
 Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>,
 syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
 <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
 <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
 <whxlizkpoqifmcvjbxt35bnj5jpc5cx6wzy3nq47zteu5pefq3@umdsbzhl3wqm>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0J/QsNC90L7Qsg==?= <apanov@astralinux.ru>
In-Reply-To: <whxlizkpoqifmcvjbxt35bnj5jpc5cx6wzy3nq47zteu5pefq3@umdsbzhl3wqm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191453 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Hi Fedor and Gao!

Thanks for your efforts. I've sent out v2 of this patch with the
appropriate changes.

https://lore.kernel.org/all/20250304110558.8315-1-apanov@astralinux.ru/

