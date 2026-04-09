Return-Path: <linux-erofs+bounces-3233-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM62EVNs12myNggAu9opvQ
	(envelope-from <linux-erofs+bounces-3233-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 11:07:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F673C833B
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 11:07:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frvG71Lcvz2yfl;
	Thu, 09 Apr 2026 19:07:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775725647;
	cv=none; b=lSi2riQyP2bqTDHfmoLS0YZQ6Pb2aXeKH84yZ7+0CVIAE/cYb5MHUFgvMlA6+a137ToNgUXULVvo3h0a9Qmmn6jjeaLR3Io6glWJeDN8SUXS9k9GcHbqndLn/pn6VN7ipV54OGk0p1HNLSXqFObaZNanescWv0rfa2Nrs0usBdhIn0AfO4KQRqUE+Fm6CRUI/FB1W6F9wJaYgOKLfbuyZzEvWwSKZ5E0+jKsKqIJiKikn71kBt8StyHtp1H5oERRns0rIuHC1p0D/YfyQECbQvrWaTkifK8ouKujPsdnQq2fcm5wzTepLkLv4jtxvqNkoruue46nBvHQInm5TjxGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775725647; c=relaxed/relaxed;
	bh=/MerAG82bEFjUY/I2bNLi9ah5RIt0MNOaJcxGOlzIJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBTO/a60ixI6RHWQvjC4icMjmtyayn3CZ8c8LSqBBg61bVPVd/JoY6oqitE8XOUL98JonzgNiWe40NEQaf7iFwl7HrUatsiBHEbz2zHuLOFqCy7/YaR/bWscXUIjkRXy1phjOuTru4OBXoRSWKTQlIXQX8Eogv63e8nCFc1hpl/UCA7Hies4YIhyn97s3c1XNmXBPmfNfeBryoUtlEl5DX9L5offFbw1Dg9RK+qHcCN5WRhx1itUVRTsdDTgv5xyEJ1QwzOsn/PHZpd2mZz4mLpzQeq0JFq3LP7/W/YLR/x29uAEMnjurzZgBuctGkzfnIF70TWSy+0f4Yx45sYGVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kg/W3B4H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kg/W3B4H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frvG60fyYz2xTh
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 19:07:25 +1000 (AEST)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2cd339aeab4so608480eec.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775725641; x=1776330441; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MerAG82bEFjUY/I2bNLi9ah5RIt0MNOaJcxGOlzIJk=;
        b=kg/W3B4Hcgw388rgpH8b3kO2O+wF3i/962XPums46aE5ZBp2GFL1wqG+pGdTq+R7jM
         W5wwhvY71/C9UTWgAIsMxJH8VrJiOW484peX0Tz82ynEZM2hfksikJBhzyJneKUE23nI
         jJ01eaQ7NxmnUQfcuCVA7w5zYDc9uTIRosgRGr8WnQR/FDrtiRgo7D7C0dXz0Yv3i2c4
         3AtmwRoyb0nWEFuAQN1gqGF9fj1vWOFRfx1EPKbjwf0f2xXuhgxLLC+EiNKn36VsllpQ
         VSRTF+qrAWNhePD3Xo3QBj2v02dOxX/DBWBsnlOExEyX5po+KcQPx4iHDdD9236k7j+2
         9E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725641; x=1776330441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MerAG82bEFjUY/I2bNLi9ah5RIt0MNOaJcxGOlzIJk=;
        b=EmvZylHAbUPZeJ5qkSXnUza9gdsA1UdLfnfa0ub6iJU95RJPAE8sCkSag+4ymQZOiG
         X2itLfnR49EmLIjJWpigGsZSmROwX4M4a0BuMxdTIweAYRiGTHBHJd42d88YHYBI1Vrb
         kFoK3SG2Eh2O1Qr+ANoBP4e3cRBAtIrNi67Wn5X1wkij2PmuWNFRYJSZMZNHEScCpbXI
         A3oCzi+mWtp6KZwfvurrdH71eih5kFTme1JaiKOf+Cw9ijmnuFz+OpYHHXjA9ePZrKU8
         YnTb4iBrATHqpGRQvLDyxmq5BgiEkl0PcY4U1MPv2kLXhEO0SqDvoqUML1S19myUGPL/
         /kCA==
X-Gm-Message-State: AOJu0YyMQOJ9aQ1rkSC+pmnvEbj3me65Y3BWLMyLjMJj5D7JL5ujckJ5
	pwr31Jao4lTSjxDtcEh5MfAOibLNp4JnjVW+2N89W7iT2dW6LASevKFhlnJYhvy5
X-Gm-Gg: AeBDietWGdHiSW643z+Eiby+s23FVv5xsh3a5q3uRqB1XimynjkP5Edy485/4k2IX19
	+t1pFK3I3rTDKlKddrFQs6cfUMf11Xx7Q7cNrelx15tVBTlqMvRRcsiGq46xojJSGGhJzlIUNcb
	GQuX3w2rAohPBSjfYk5H5lQVdMx1lVJ+w1Mzu5+YImN9eC2qFGTxo3RfRGoe+JgqAu9DN4h64ij
	/aQWYjreU3h4ymIGHtoMpB8BKB2UERbNTPFMgTpWxq0r6RPUtXCHq9pdCt3xkvPiJGOb1B1mOf1
	S4Urpd6Tz2fV6cM2HsbiZcNdYZlkockz/crQo8mc+I5YyySDCGx4mcS997KKG4C2asa5a9W/yT3
	k+WEKYEicQydDVAEwgUxM7I558lN47m+lP34sS+qoPBe3x8Hfg3hM6tt4EXC8RuGBW216U11mAr
	Ym4ZAJRn+NriK+RqREvwKUYePD2Kasi18a5yUYONaTXRaoXf3uo1UVg2gc
X-Received: by 2002:a05:7300:3254:b0:2c1:7fd3:4504 with SMTP id 5a478bee46e88-2d40bf15e13mr1394698eec.3.1775725640798;
        Thu, 09 Apr 2026 02:07:20 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2bc2c40b1sm7268778eec.3.2026.04.09.02.07.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 02:07:20 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: newajay.11r@gmail.com
Cc: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: support --blobdev with block map
Date: Thu,  9 Apr 2026 14:37:13 +0530
Message-ID: <20260409090713.51262-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409084834.147-1-newajay.11r@gmail.com>
References: <20260409084834.147-1-newajay.11r@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3233-lists,linux-erofs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 01F673C833B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ajay,

Thanks for looking into this, but this patch is redundant. I already
addressed this exact TODO item last month.

My initial patch was sent on March 7th. After discussing the
implementation with the maintainers, specifically addressing Yifan
Zhao's feedback regarding the 32-bit address limits for block map
entries and the necessary fix to reset m_deviceid in erofs_map_dev(),
I submitted a finalized v2 on March 9th.

Additionally, following Gao Xiang's guidance, I have already written
and submitted the corresponding test case to theexperimental-tests
branch as of March 19th.

I strongly suggest checking the recent mailing list archives or the
pending patch queue before picking up a TODO item to avoid stepping
on ongoing work and duplicating effort.

Regards,
Nithurshen

