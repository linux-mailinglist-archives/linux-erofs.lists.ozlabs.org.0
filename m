Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF96F31D7
	for <lists+linux-erofs@lfdr.de>; Mon,  1 May 2023 16:09:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q94pG6KQVz3bY3
	for <lists+linux-erofs@lfdr.de>; Tue,  2 May 2023 00:09:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=YC4w0rZz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=daan.j.demeyer@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=YC4w0rZz;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q94p964V4z2xvF
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 May 2023 00:09:19 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b35789313so1732039b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 01 May 2023 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682950156; x=1685542156;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tgWYmDSBrHK9dRbGmusK2WsurJ/6FFu+p0EIz76RS0Q=;
        b=YC4w0rZzo4lEiiCuRCJdwktiTVHmAeOOI6B/hAelM2+k9Gi/VdYeClR/lSBtNgbR1w
         6hI/lcsAbS4zRwUFlru5M5wbwAYDJPaooN9wlKlbzE9TXcOm5N3tFkX5XNNMQ0C538Nm
         28KPLEZEEhSD0Fo1un25YDa3bWQvvR5jOGj4CTMYRE10Kdf6Sz6VllPctVaFVcUiUD/V
         VBsoMLZrzdY795Bfskwci69RybzkKVnXttOPsIekrZLen9fLqfbWeSSw3+ipbWbhG/PD
         d4NLy7nWbtrAku0j4X3/XXU2c1ImCQv7ec4KgotCiI1CwHMLcq9DV9e8lQPCVtGKUWzP
         6VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950156; x=1685542156;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgWYmDSBrHK9dRbGmusK2WsurJ/6FFu+p0EIz76RS0Q=;
        b=e5BYU22JHgYJ6qDs+wTuhmRJYlhpPgZP5Or4FH3vqCCnPoXKDT78KKe0r8dKyCIZsE
         2QygRl6JXpbS0wCDPzEOyaZflLbyFuJMce8N5l17pUHs1hfuoiUsWuKU8i1jwv/Hjs4m
         RgROyFg67a+6BUYFpcSvmLVKVh8LSnhPmw4979ZKQ24ZzPohHA6bkV1Bkm4fcoBHyfe7
         eRxOy7duEzXD4ZotzNUQjcFqXmr9JTxNaq+l0ETHpQVumRObGnyOItwqXLBxMvVOHy7B
         6SpHw4qjnBHfLMpDcvqKJYEX+nPsee3C9dxuN6bRBELeUBiy5yGzYRcCamQETmsjmNW7
         +/ig==
X-Gm-Message-State: AC+VfDypoOn/pDlR1f6uzEeFE0aKXCGQFzL4086EOZNGm1z/cc0zEKkc
	LZD1ou3/kUmhlRsifs6c+D1nEA4q5M43N+YKdMWGkwLd84+vRw==
X-Google-Smtp-Source: ACHHUZ52uNa2pIriu9lwPF+VV9SzKEUBStp6sBOpyamS+lO2uO4YNC9KTLxxbJrFRyKN0YTAw5LtoKlGcK6L7WZxMdo=
X-Received: by 2002:a05:6a21:100e:b0:ec:843a:6388 with SMTP id
 nk14-20020a056a21100e00b000ec843a6388mr15225796pzb.26.1682950156147; Mon, 01
 May 2023 07:09:16 -0700 (PDT)
MIME-Version: 1.0
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Mon, 1 May 2023 16:09:05 +0200
Message-ID: <CAO8sHc=vxhp_+98Om7C83zOyXmdAkAxeoOrnffgwqkPntvO2fw@mail.gmail.com>
Subject: Merging multiple erofs file systems on the same block device
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I've been looking into erofs as an initramfs replacement by using
root=/dev/ram0 to tell the kernel to load the initramfs as a ramdisk.
However, by using a ramdisk instead of the usual compressed cpio, I
would lose the feature where the kernel merges multiple individual
cpios together into a single tmpfs filesystem. Looking at the
documentation for erofs, I noticed that erofs already seems to support
merging multiple erofs filesystems on separate block devices using the
device= cmdline option. Would it be possible to extend this so that
multiple erofs filesystems that follow each other on the same block
device can also be merged? This would allow me to pass multiple erofs
filesystems to the kernel via initrd=, which would get concatenated
together into a single buffer, which the kernel would write to a
ramdisk (using root=/dev/ram0) which the kernel would then have erofs
mount to /dev/root. erofs would notice that there's multiple erofs
filesystems on the ramdisk and overlay them together (perhaps only if
a cmdline option is enabled).

Does this make sense at all?

Cheers,

Daan De Meyer
