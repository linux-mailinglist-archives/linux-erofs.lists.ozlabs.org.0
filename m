Return-Path: <linux-erofs+bounces-3010-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOYUHZ2ExGlF0AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3010-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 01:58:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C000732DB7C
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 01:58:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fh53q1rynz2yY9;
	Thu, 26 Mar 2026 11:57:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774486679;
	cv=none; b=X9hB1D1k8IR+4fFDl6OP+xwVD4zjQVh9HMHmNA7+qOIC0eQ7Ttep+jTaPQNfa5lTXR6xoYyhzHo8DO7w1hl/Kio4MMR+FW6O08LB7afuyIJY9XSHr/7NGYsf4daj9kbURQi3v1UDddstxx3TkWULA2f2u9a60gZ7A/k2sNaiJ6TIKNYKU137+E/R8APLbLPxDbAddb9XddCCXL/85H2tyHs6MBc9iBtwQp5Ors+f0N2qnFJ9LLFxAyjtUAD2fOHHPnbBz43NGvL9nu/3dFaOumZdyS2BUMETEj18PYyVtMSbOfaW7hjqTy0ay1aXKNELaJSoIjblYBZx91Vo/hyMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774486679; c=relaxed/relaxed;
	bh=FZCt8QaWLapiU2n8zrh9FnVYvYc0EuZasloZjLe4fjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvW88yazD5TD9L7n1u4HuBAGCViWozlr/zsvZ3Giu1JUz3KRkAAjCkTA4BntLtk9UZoKd4aLP8M5ykF3F9E2h7ao8WuCTVyldsFPLzQKv4UN+UjqTVbm6715UJ6b2m4ggQ14yVTQlkZxQ8lpzNwjeBpwzjoh4uo/VCdyTLqHLw1b1kt9wLvCbShKhLU03dgaglMOaFG4MV5p2E31YBYZEs1k+5oxLI6fjwdrul+1OpQEXfiR/BkMg//ZWmXV+qwUGdFRchRx5emRug1VkMBt1Ryja6uwPWGgPHtsUSlKIuqQPuYSXsEdeiAy8O4apXBnYZ3NL9FcrGjBy6d9Kbxlpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e+Xn7BW0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e+Xn7BW0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fh53p23jtz2xN2
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 11:57:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 90C0540891;
	Thu, 26 Mar 2026 00:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0769DC4CEF7;
	Thu, 26 Mar 2026 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774486675;
	bh=OxiDEIWxmoXvZq2GktVGGq/OI75Vn8HDTE92h1t+gxY=;
	h=Date:From:To:Cc:Subject:From;
	b=e+Xn7BW01vSCt+T06kR9xMFAzIVVQvwuVzBD0CAoyD1LWaLfu1ShpwikOYQL8DCy3
	 tWjusluKuc3cLJlOI1YsvyjVbs1NxKP60+MN35YeiHQ5o8T/yzt9KzEJ9wFriM3pQ9
	 5sjpENMz2leYeA7pFUMw979N7lXU4ez5Wu29+kTs55NY5eTz98GMTMMoqNmOv558dJ
	 gejm0FeQ+w3JUXiQYFGJTxXtXKG2MVe4O/YOiNWM7QhiW4VCuM1UIwN9HWvR/i0jBE
	 LuGo56khZ9hVUOb6DtNCPmj7qUcSxgJYvJ71CTEHtoN+1hWV+9e94b+yxxS19udmi3
	 3W9b4eOJ3w40Q==
Date: Thu, 26 Mar 2026 08:57:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 7.0-rc6
Message-ID: <acSEi76uD7DCHJ6d@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3010-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:shengyong1@xiaomi.com,m:jiucheng.xu@amlogic.com,m:lihongbo22@huawei.com,m:chao@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C000732DB7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

Could you consider these fixes for 7.0-rc6?

There are three random fixes and a Kconfig refinement.
Details are shown below..

Thanks,
Gao Xiang

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.0-rc6-fixes

for you to fetch changes up to 2f0407ed923b7eb363424033fc12fe253da139c4:

  erofs: fix .fadvise() for page cache sharing (2026-03-25 10:40:02 +0800)

----------------------------------------------------------------
Changes since last update:

 - Mark I/Os as failed when encountering short reads on file-backed
   mounts

 - Label GFP_NOIO in the BIO completion when the completion is in
   the process context, and directly call into the decompression
   to avoid deadlocks

 - Improve Kconfig descriptions to better highlight the overall
   efforts

 - Fix .fadvise() for page cache sharing

----------------------------------------------------------------
Gao Xiang (2):
      erofs: update the Kconfig description
      erofs: fix .fadvise() for page cache sharing

Jiucheng Xu (1):
      erofs: add GFP_NOIO in the bio completion if needed

Sheng Yong (1):
      erofs: set fileio bio failed in short read case

 fs/erofs/Kconfig  | 45 ++++++++++++++++++++++++++++++---------------
 fs/erofs/fileio.c |  6 ++----
 fs/erofs/ishare.c | 15 +++++++++++++--
 fs/erofs/zdata.c  |  3 +++
 4 files changed, 48 insertions(+), 21 deletions(-)

