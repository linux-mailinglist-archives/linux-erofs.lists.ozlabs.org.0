Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A615595A4
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jun 2022 10:48:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LTrPZ28hmz3c8c
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jun 2022 18:48:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=menstockings.com header.i=jea.moo@menstockings.com header.a=rsa-sha1 header.s=dkim header.b=ngEr2J7C;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=menstockings.com (client-ip=45.130.138.47; helo=izattish.menstockings.com; envelope-from=jea.moo@menstockings.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=menstockings.com header.i=jea.moo@menstockings.com header.a=rsa-sha1 header.s=dkim header.b=ngEr2J7C;
	dkim-atps=neutral
X-Greylist: delayed 1804 seconds by postgrey-1.36 at boromir; Fri, 24 Jun 2022 18:48:30 AEST
Received: from izattish.menstockings.com (izattish.menstockings.com [45.130.138.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LTrPV4Tj7z3brj
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jun 2022 18:48:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=menstockings.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=jea.moo@menstockings.com;
 bh=+VeES48QpIkV7NIzAFOXgXRRUlE=;
 b=ngEr2J7Ch1xY1AiOqcfQrtMbK9Mw/B/n5zTOzVTuDWpuwmilOPhIAimQBmH7AQVDnf5T/DEiXpx9
   Hnxb1HCGQkq+o8EM8AU7LDtPKG0K9DtY0QCB2hc/aloyF1T70MCyq6v47xMXl3h3OtUHJihAbSKK
   55VaCEWBuLEpwz/8xcxP+j+qCjE9p/HZuAktVmeNlEqyxZ5cMlNKqva0xRTrjKkVvZlsY1y70onD
   koPeSVfpIvzsExZV8dqsNyYee6+9+U/VMlxk9rqdmkeM+ckYTvknaBgZEQ2+Iqew5MsWK13xFPhL
   MjP4htf+4jl3ZJLZLMMcnj+ZGN0V0v97l2pNzQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=menstockings.com;
 b=biKhSvHQfdgcayWvV/c2u0Qv479BXptrTXP+1PAMii8ohbizucIBjc7cURSfsV2sb/jNePm1EStQ
   zJ750DqfpI+g+mo20hP8TnYOTRDT7a99wpvLMbb0KVxudWwr+nJTLUfjxGgOBAIxLv/s3dfeBjXL
   /2Xjzi/co7kPSzXxJESnL3ge+mMA+nSPYahGno1VFMW3DBuvYskmje1o3pDTMfuaDIsWlg+m8Qt/
   HFt/hyhWzlMGPHAn8cmQF4ZD/ZL3xVx5hdOTGLIqJeHDBznlS/sRTvMtTDOClicRtHQJGBbWZnrf
   0xQn58feH08rLhmM9OfF13YQk60js2Ldgws+yQ==;
From: Nathan Bailey <jea.moo@menstockings.com>
To: linux-erofs@lists.ozlabs.org
Subject: Business
Date: 24 Jun 2022 02:48:24 -0500
Message-ID: <20220624024824.4A9F72DC629CBBB4@menstockings.com>
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
Reply-To: drnathanbailey59@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<body style=3D"MARGIN: 0.5em">
<P>Hello,</P>
<P>I'm Nathan, a Research Assistant of Gene Laboratories Ltd. Please did yo=
u receive my email yesterday? In acknowledgment of this message, I shall di=
vulge details of my intent for your consideration.</P>
<P>Warm Regards,<BR>Dr. Nathan Bailey. PhD.</P></BODY></HTML>
