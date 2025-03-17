Return-Path: <linux-erofs+bounces-82-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D186FA64679
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Mar 2025 10:03:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGTX3371Tz2yLB;
	Mon, 17 Mar 2025 20:02:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.209.161.160
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742202179;
	cv=none; b=IXbUtGxU3mTqgvy9LRj9Yi+yVExeBSswiJdUu1vCrPkdWgQCOFacLrdoaG8AEn5KPcCjyq7UB+wK0OR6NNah/Y1HTdTgnPZ8xUuPwv2aMWyYEHyl1lPNucJx7evAp6BtDTQa3LYYyyd3DDJ0nivqY9NwP0wwIqj7Q3+0EzZMb5VrLeRZBITfZbQqsG0pD+Fvn1Vol6kYY8bO8NjTVXL4/A6yC1Vt3m5OGnmkT8tfOcW7rJHffnou/5H4GANQiE7nuiXbicJFnhJ57u2892HYhcH+HUv6KEDEEq48dK1KyOIBqKLwGvQhP17nsVTujW14+5Zkljuen35KHNCPmN8XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742202179; c=relaxed/relaxed;
	bh=Z4uGdR0Qbg2dV7GYQW0pJPAOYKhMPQuuIJuUDDJMkI4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1CJQKlFUCOXvn+ZyDOnpdg9VQuwTNJ8PSoTC7hkxnJDRAbCjxZGAOZo06+8n1rrJSULLP3OHnTYD2jqYvNoVFXrIVMVzcBxINMIRgzB4vn/iuTCxq6N/22XWLtkUHj8stOeZ4xwHh+rQxWbUKCpxfKrXF8szg7jF5TqA2Xv6NLDz2VtPGJKjVZSqw1jKYmRUTQqdsqLWYuJlBpuHjFzv9bDua9YEB1y3otJidh24XeeVisfe2Meg76jB9nQc8h4qtiv0ZTEBNPM6Xlx7nDEoxnsdAFCCRy3mRBktVWTdlTNora1cPecp4z3ZfYF05wheoRHao8akHM4ziD5gO0pDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=movieroom.space; dkim=pass (1024-bit key; unprotected) header.d=movieroom.space header.i=contacts@movieroom.space header.a=rsa-sha256 header.s=default header.b=EH+V8Y1B; dkim-atps=neutral; spf=pass (client-ip=185.209.161.160; helo=aza0.movieroom.space; envelope-from=contacts@movieroom.space; receiver=lists.ozlabs.org) smtp.mailfrom=movieroom.space
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=movieroom.space
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=movieroom.space header.i=contacts@movieroom.space header.a=rsa-sha256 header.s=default header.b=EH+V8Y1B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=movieroom.space (client-ip=185.209.161.160; helo=aza0.movieroom.space; envelope-from=contacts@movieroom.space; receiver=lists.ozlabs.org)
X-Greylist: delayed 604 seconds by postgrey-1.37 at boromir; Mon, 17 Mar 2025 20:02:58 AEDT
Received: from aza0.movieroom.space (aza0.movieroom.space [185.209.161.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGTX22bvCz2y92
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 20:02:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=movieroom.space;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=contacts@movieroom.space;
 bh=Z4uGdR0Qbg2dV7GYQW0pJPAOYKhMPQuuIJuUDDJMkI4=;
 b=EH+V8Y1BDfuxMCvhzqsVIeU2QlsZbTnB865+g0dGkrgY1XYuM9OQ7PWwHroopEJzuRaW8dfNkMOj
   WOsvW9MHm201AwhSIDOt3XlIQPjlG2yDf0uHvxbhkdOjRhtIQ2blPP+n24V+VD9G03kmLThk9q+x
   Za8488F+DR9m//fBsfE=
Reply-To: Salem Mohammed  <salem@integrateqatar.org>
From: Salem Mohammed  <contacts@movieroom.space>
To: linux-erofs@lists.ozlabs.org
Subject: Availability of bulk purchase discounts
Date: 17 Mar 2025 08:52:49 +0000
Message-ID: <20250317085248.2F9B309530D197AF@movieroom.space>
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
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM14,HTML_MESSAGE,
	MIME_HTML_ONLY,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;">
<p>Hello,</p><p>We are interested in purchasing your products for our marke=
t in Doha-Qatar.</p><p><br>Kindly confirm below:</p><p>Discount: Availabili=
ty of bulk purchase discounts<br>Delivery: Timely and reliable shipping to =
Doha-Qatar<br>Payment Terms.</p><p>We look forward to receiving your reply =
so that we proceed further with our first purchase..</p><p>Regards.</p><p>S=
alem Mohammed Salem<br>General Manager.<br></p><p>INTEGRATED TRADING CO. WL=
L<br>
Adjacent to Qatar Navigation Plaza on C-Ring Road<br>P.O Box 24804, Doha-Qa=
tar</p>


</body></html>

