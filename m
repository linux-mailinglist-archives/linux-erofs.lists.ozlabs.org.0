Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0605A40D0
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Aug 2022 03:55:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MGD6Z4zdlz3bk9
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Aug 2022 11:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=questairinc.com header.i=kit.mat@questairinc.com header.a=rsa-sha1 header.s=dkim header.b=b79SelNM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=questairinc.com (client-ip=85.217.145.162; helo=aoljkotl.questairinc.com; envelope-from=kit.mat@questairinc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=questairinc.com header.i=kit.mat@questairinc.com header.a=rsa-sha1 header.s=dkim header.b=b79SelNM;
	dkim-atps=neutral
X-Greylist: delayed 1870 seconds by postgrey-1.36 at boromir; Mon, 29 Aug 2022 11:55:31 AEST
Received: from aoljkotl.questairinc.com (aoljkotl.questairinc.com [85.217.145.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MGD6W07wkz3bb2
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Aug 2022 11:55:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=questairinc.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kit.mat@questairinc.com;
 bh=Am2oPma6KTJm7jD1UNmQrQ812tg=;
 b=b79SelNMNC3q4qibiCFkSSwHgrr8gq6mc4m202h/HemIAO8FU2f1bFBDNYthHtLlUxI2LjRiuQX6
   Qoojx+Icm5qsnuxAGHaVb1yECXkPXj8C7zU4b+7pbyGuD3PfrjI6hWO8pbCGFip5JPzMpk0bb9Mm
   uiYUlXHOamKt7M6s3Sf84TmmXi0YVENq9H6dPe5sGtACXcB7S5sdyrg3NmV1h/nnfd1AkU/tqXfi
   KYA3DRvn8PT66nmJZHT/ADiA5v2krYFv314agUI53HA5f6MCiwg33Qmw3zgDL38K77qGgtU7Oqbg
   fxfyp2Y0ySeeHP7Q5aJrC//f239KiSooIC+pSg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=questairinc.com;
 b=j6DexdDxoLN2+xCn15WWezyET+7zXqLqXEdULIE5Z7ih4lqhmpc4Eier8tQh8dQ07NKOh2xrIDC7
   +rmF73z6CS30xuHQeaUtMmFezr1sHrSV3hvkkDX+7drsm4u3whUk/ISC4qoGnP2dYenRIuo/3hJ6
   5RDLNNwnd5nSyqRFCQLBmByvqV+VSZgIStLj1RNb5Rl3sJ49c15l6M0PYcXgAhRGwbmIR1HUIbBN
   jLC72wpHfLcwnW3qTEnDmOu8s74ioCrXiQB+DeT+CFKnZwjrcOALL72TykoWkccqz4I0Fc5CEWVO
   uSu5/wrn2X/WEKXqkOYbVIrGqrJcXIl4sGWPPw==;
From: "Damian Murthy" <kit.mat@questairinc.com>
To: linux-erofs@lists.ozlabs.org
Subject: Business proposal for linux-erofs@lists.ozlabs.org
Date: 29 Aug 2022 00:57:31 +0000
Message-ID: <20220829005731.C90BFA4DCFABAAD5@questairinc.com>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: dmurthy12@yandex.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<BODY style=3D"MARGIN: 0.5em">
<P>Hello linux-erofs,</P>
<P>I am Damian. I work with a bio-pharmaceutical company here in the United=
 Kingdom. I have a business proposal for you. I want us to partner in a sup=
ply business to my employer, where you will represent the seller.</P>
<P>The profits are worth the efforts and you do not require experience nor =
expertise to participate in this. If you are interested, kindly respond to =
this message.</P>
<P>Kind regards<BR>Damian Murthy</P></BODY></HTML>
