Return-Path: <linux-erofs+bounces-1109-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C29BA1E9E
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Sep 2025 01:03:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXq5g1NY1z30FR;
	Fri, 26 Sep 2025 09:03:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.178.32.196
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758841431;
	cv=none; b=Uwk7RfxFWrJ2r4ohQP/bt2Ibq99wNKlqqwj/k1kYG3j/Z0TQ0/G8OVDfN6wZ1k4iOzI/yRA+hB+yHb3piAW3suK19yTWVC8ZWc0lrfXm58neDuId3OnpgFBOqMQDY8K8i4Nbx5ckp5VDmaSKUOF9RwM8n9jMCncwwPMSra7n8zpbvx20KUrfYG/RKau3ib506fz/ICu2GS4n1wQwU5YcVqQ1BPlnEobQDYByvFUlwRdnAl4j2rAnbHokhoXh1F1+QEJV9sAQbjvZ9beP2q3ZOxEZMfPfHI2VMN2swJCtOdQNvLTT7bwsmXAscgLYF0r4RO7Th7n5Y7AT95YP0sZpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758841431; c=relaxed/relaxed;
	bh=ACxqKKsz61L277xxADo2DVbpseAqoC60EVRCvf+wlCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IW/wuF9r0VynsXAh8kft3oHWAMS6AUCKiDkLdpls7OsbGjJV6kwGJ+9hSacSXHUClf8AOLo++5HKSFexoM2EPzA7l2aqIPiedCRfs+RMvlQHFm0DNWHJ0Gu2YmdRG7WgGcB3whWVqccH32JIY38vFE1uehv+81xCH9/u/Z1VvneMpZ3VlbWuKcPcFWQIMtnRIAgfY3yQg1AwFV/kzif5BPONIX64iiMEwB3iujCgSHVE2c2NdpuuVZxy7MLkyDDhsS6/1orulcZflYdCLd0kHljLyWWTKe6IlWvtT264yDcbFy4hk/S69p7ydgb3O4vMY9o7IsYuMnfWhcleaSE+uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=afecc.com; spf=none (client-ip=220.178.32.196; helo=afecc.com; envelope-from=sogecoa_zby@afecc.com; receiver=lists.ozlabs.org) smtp.mailfrom=afecc.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=afecc.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=afecc.com (client-ip=220.178.32.196; helo=afecc.com; envelope-from=sogecoa_zby@afecc.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 324 seconds by postgrey-1.37 at boromir; Fri, 26 Sep 2025 09:03:49 AEST
Received: from afecc.com (unknown [220.178.32.196])
	by lists.ozlabs.org (Postfix) with SMTP id 4cXq5d611Dz307q
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 09:03:49 +1000 (AEST)
Received: from [160.25.73.47]; Fri, 26 Sep 2025 06:56:05 +0800
Reply-To: lewiston.freeman@e-fcl.com
From: sogecoa_zby@afecc.com
To: linux-erofs@lists.ozlabs.org
Subject: Confirm this letter -----
Date: 26 Sep 2025 05:57:14 +0700
Message-ID: <20250926055714.EA0C59E950EE65B9@afecc.com>
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
List-Unsubscribe: <mailto:sogecoa_zby@afecc.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Flag: YES
X-Spam-Status: Yes, score=4.8 required=3.0 tests=RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L5,RCVD_IN_PBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
	*      [220.178.32.196 listed in zen.spamhaus.org]
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  0.0 SPF_NONE SPF: sender does not publish an SPF Record
	*  1.3 RDNS_NONE Delivered to internal network by a host with no rDNS
	*  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
	*  0.0 RCVD_IN_MSPIKE_L5 RBL: Very bad reputation (-5)
	*      [220.178.32.196 listed in bl.mailspike.net]
	*  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Good day,

Greetings to you , I want to legitimately introduce myself to you=20
,if you don't have confidence in my introduction and the details=20
of this letter , no need to reply to me . My name is Lewiston=20
Freeman, a supply procurement consultant a pharmaceutical company=20
, a major manufacturer of Biopharmaceuticals products,=20
Coronavirus vaccines and various lifesaving antiviral and=20
retrovirus vaccines, Healthcare consumables, Supplements and=20
Cancer treatment.

I need your participation in the procurement and supply of a=20
major Herbal Raw Material that my company uses for the production=20
of the above listed lifesaving Biopharmaceuticals products, and=20
you may eventually become our company's permanent global=20
supplier. My company purchases this major Raw Material in large=20
quantities and needs this raw material urgently to commence=20
commercial production of these Biopharmaceuticals products,=20
antiviral drugs and vaccines.

This may not be your area of specialization, but it will be=20
another income generating business outside your specialty, as I=20
just got a local producer of the needed product on a very lesser=20
price to what our company budget price to buy the product, if you=20
will be capable to handle this supply we can partner .

Upon receipt of your interest, I can share more details of this=20
lifetime opportunity for your review and consideration.

You can also drop our direct line with WhatsApp.

I await your response.

Confirm you got this letter.

THANKS.

Regards,
Lewiston Freeman.
Business Broker.
Email: lewiston.freeman@e-fcl.com
Mobile/WhatsApp : 007 95 197953.

