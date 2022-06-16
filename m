Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01EA54DC36
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jun 2022 09:54:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNvb35Hncz3bkt
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jun 2022 17:54:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=fulltravel.it header.i=@fulltravel.it header.a=rsa-sha256 header.s=default header.b=pZ8BcKTv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ds1313.tmddedicated.eu (client-ip=107.6.142.131; helo=ds1313.tmddedicated.eu; envelope-from=fulltravel@ds1313.tmddedicated.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fulltravel.it header.i=@fulltravel.it header.a=rsa-sha256 header.s=default header.b=pZ8BcKTv;
	dkim-atps=neutral
X-Greylist: delayed 4033 seconds by postgrey-1.36 at boromir; Thu, 16 Jun 2022 17:54:31 AEST
Received: from ds1313.tmddedicated.eu (ds1313.tmddedicated.eu [107.6.142.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LNvZv19XXz300x
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jun 2022 17:54:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fulltravel.it; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Reply-To:From:Date:Subject:To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UI++/9pSZiDfomSfGGKgaGKGjhOGZHdgbxTirMh3AHo=; b=pZ8BcKTvHWu7/2ppj+MCqIyqFy
	PUNgHQKxi1E5mNgMFheQkkqBHdqwpQ3zfWT+5aj0rDw+o9YDS3+KX+GuKtsKokpyuLpo/bQzKV3Sw
	mlaa2QzAtES24TVq9ouUZroW6bsrK3lOyheHbbeWdWKBC5yr5TpOKqCRfCiMtE7Wzqo12ssPUnOhW
	E3Y7qCOq9u53Q8nNeK5sIxru6ppvp/n05pQevLjEU/X5kYQhoEY/Xz8NEmFF7QB7LhHyMAC3H7Wki
	f+Np1XzEohVQZ62fTYI6NQotfUAGtttCQYbfCvWWcjyiair7ykPL5Up8J7nVI93ETqDbzQ/8Xnx7d
	UUvMqRHQ==;
Received: from fulltravel by ds1313.tmddedicated.eu with local (Exim 4.95)
	(envelope-from <fulltravel@ds1313.tmddedicated.eu>)
	id 1o1jHc-0004uf-6Z
	for linux-erofs@lists.ozlabs.org;
	Thu, 16 Jun 2022 06:47:12 +0000
To: linux-erofs@lists.ozlabs.org
Subject: =?UTF-8?Q?Contatto_Pubblicit=C3=A0?=
X-PHP-Script: www.fulltravel.it/index.php for 162.247.74.7
X-PHP-Originating-Script: 1002:PHPMailer.php
Date: Thu, 16 Jun 2022 06:47:12 +0000
From: "FullTravel.it" <noreply@fulltravel.it>
Message-ID: <d2JsKEnQQr2q02QdgHtTVf06fDubXPKNUu2WnGDM7b0@www.fulltravel.it>
X-Mailer: PHPMailer 6.6.0 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1_d2JsKEnQQr2q02QdgHtTVf06fDubXPKNUu2WnGDM7b0"
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ds1313.tmddedicated.eu
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [1002 993] / [47 12]
X-AntiAbuse: Sender Address Domain - ds1313.tmddedicated.eu
X-Get-Message-Sender-Via: ds1313.tmddedicated.eu: authenticated_id: fulltravel/from_h
X-Authenticated-Sender: ds1313.tmddedicated.eu: noreply@fulltravel.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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
Reply-To: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

--b1_d2JsKEnQQr2q02QdgHtTVf06fDubXPKNUu2WnGDM7b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Da:  Julia want to meet you! Click Here: https://queen22.page.link/photos?64b 
67glyq
Telefono: 473467038470
Motivo del messaggio
Email: linux-erofs@lists.ozlabs.org
--
Questa email è stata spedita da FullTravel.it (https://www.fulltravel.it)

--b1_d2JsKEnQQr2q02QdgHtTVf06fDubXPKNUu2WnGDM7b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">
<head>
<title>Contatto Pubblicità</title>
</head>
<body>
<p>Da: <img src="https://s.w.org/images/core/emoji/14.0.0/72x72/1f970.png" alt="🥰" class="wp-smiley" style="height: 1em; max-height: 1em;" /> Julia want to meet you! Click Here: https://queen22.page.link/photos?64b <img src="https://s.w.org/images/core/emoji/14.0.0/72x72/1f970.png" alt="🥰" class="wp-smiley" style="height: 1em; max-height: 1em;" /></p>
<p>67glyq</p>
<p>Telefono: 473467038470</p>
<p><strong>Motivo del messaggio</strong></p>
<p>Email: linux-erofs@lists.ozlabs.org</p>
<p>--<br />
Questa email è stata spedita da FullTravel.it (https://www.fulltravel.it)</p>
</body>
</html>


--b1_d2JsKEnQQr2q02QdgHtTVf06fDubXPKNUu2WnGDM7b0--

