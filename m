Return-Path: <linux-erofs+bounces-47-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADDA5B6A8
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Mar 2025 03:25:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBd015vsYz2yQl;
	Tue, 11 Mar 2025 13:25:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=160.251.207.67
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741659921;
	cv=none; b=kn5aqWLZa2UGbDk4RSqKWl/kX7kQNaNlj/6QH7IyYPlGe9JuI/6Bv32DR8qm0ToyHaxILGB/SOGSEE1XzFgRlH9j113/HP8zCmZNMl9D87Z1FBKOJTxEJ0BSrQBmnqDTBkKwlV8MtAbOfst/ML+BLLiWMAN+5nhUKxvsFI6k2Od4d64Fz//s6kF/1foKQ0mgG6CnEp1hTzupiOQ0AJasTuHfuiY+5JGaPkiVQsrOzn1GKEY4QyG7jWPyiK9ubosCx+kIxJa+HzrqLRhKe19og33253CvFCguoa4p8dEIg4ph0KrTHWF0z6cL/yvTre+MQzfgQWeXwtwx0zImtHobHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741659921; c=relaxed/relaxed;
	bh=PxejmGCkwI+INU4iqrdcIY90/AaS4MHTvdBvUkqcCAM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LeaeKnRwWpMsiKfgy8N/LYOELo1zGiQdPn05TPy8sPWAVytHasHHFX1x/t+j28Js/5HQAfTwA008yJNxl5a6ItxUnbHda4pxRlyWUNmRLKydUOJa/Tis6yv86Ru2p/8XidvjgUzZMdR/JdX2mc6kCZZKeKfPONjiGQ+yQb8e90N/6Qx5MeleSHVcexDf8UxQR6GrT4O32LhUj1dhgSX+kh4aA4fdTbpFa32Gofbt3uw16k1E4oissAX4uzHqLLqHgcrPLtv+U6tlt+f7eiWhQUEoZ+NoS1RMLZ3toRUVK48ffOZV8ymiVVed5ilHhq+G10s9uQ//6Pyuz+AkfcyaZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ykd-delivery.com; dkim=pass (2048-bit key; unprotected) header.d=ykd-delivery.com header.i=@ykd-delivery.com header.a=rsa-sha256 header.s=mail header.b=JztX6wJG; dkim-atps=neutral; spf=pass (client-ip=160.251.207.67; helo=ykd-delivery.com; envelope-from=service_1@ykd-delivery.com; receiver=lists.ozlabs.org) smtp.mailfrom=ykd-delivery.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ykd-delivery.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ykd-delivery.com header.i=@ykd-delivery.com header.a=rsa-sha256 header.s=mail header.b=JztX6wJG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ykd-delivery.com (client-ip=160.251.207.67; helo=ykd-delivery.com; envelope-from=service_1@ykd-delivery.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 693 seconds by postgrey-1.37 at boromir; Tue, 11 Mar 2025 13:25:19 AEDT
Received: from ykd-delivery.com (v160-251-207-67.cqpf.static.cnode.jp [160.251.207.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBczz10Gtz2yDk
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Mar 2025 13:25:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ykd-delivery.com;
	s=mail; t=1741659220;
	bh=kZuaXx9WBG/LnWtWK12p6u14o8PbrNXwuzAk6h8YxAc=;
	h=From:To:Subject:Date:From;
	b=JztX6wJGppczIi0tAHK9eq885dfT5vJ3SduT4azz7FpzeZ3rJzg+V8tEZpB/kSUUW
	 OJK4h2Kranaea/zLicjJalEqJhG1m6CCZqUVPQ3X9YeFu1FqE58zRb75+3Oe0ubRwj
	 u9jEUJY/yxEinKL7n6hw3ZBOQvrsHqgJIoT2tBYKX/5ZzWb+ym6W4eDK71RgO4oW1t
	 UWE7zeqRtvSv6GgBUy8O6ujNpVhChNVxMhDfStK3/Al5WueTyM9dvJQzjiE8181dQ0
	 w6l1X0j8ULzI5/ulo2zujLcsyLc9er7h5PHIHzliU54VMj1b8fFq4VgXGXYakouKTJ
	 wFC638bwTHxFw==
Received: from ykd-delivery.com (unknown [157.7.89.244])
	by ykd-delivery.com (Postfix) with ESMTPSA id 966FF1018A8
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Mar 2025 11:13:40 +0900 (JST)
From: linux-erofs@lists.ozlabs.org <service_1@ykd-delivery.com>
To: linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: =?utf-8?B?6Kaq5oSb44Gq44KL5Y+L5Lq6MjM4NjY=?=
Date: Tue, 11 Mar 2025 11:13:26 +0900
Message-ID: <009e30ec5c00$3339e815$7c8515eb$@ykd-delivery.com>
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
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_067F_0163FD06.13D3F6F0"
X-Spam-Status: No, score=2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,HTML_MESSAGE,
	MIME_HTML_MOSTLY,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

This is a multi-part message in MIME format.

------=_NextPart_000_067F_0163FD06.13D3F6F0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64


------=_NextPart_000_067F_0163FD06.13D3F6F0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0
Zi04IiBodHRwLWVxdWl2PUNvbnRlbnQtVHlwZT4NCjxNRVRBIG5hbWU9R0VORVJBVE9SIGNvbnRl
bnQ9Ik1TSFRNTCAxMS4wMC4xMDU3MC4xMDAxIj48L0hFQUQ+DQo8Qk9EWT48L0JPRFk+PC9IVE1M
Pg0K

------=_NextPart_000_067F_0163FD06.13D3F6F0--


