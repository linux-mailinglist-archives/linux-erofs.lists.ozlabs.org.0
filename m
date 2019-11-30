Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AB10DEF5
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 20:43:05 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47QMHB50nyzDqvD
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Dec 2019 06:43:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435;
 helo=mail-wr1-x435.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="frHnroG8"; 
 dkim-atps=neutral
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47QMH46BlwzDqsr
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Dec 2019 06:42:53 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id b18so39058120wrj.8
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Nov 2019 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=RCS+4Ey3rNNMXxja15cF4U80QWLQgMgI8w0IYpV4xJY=;
 b=frHnroG8pKmo5eNfsWnHqDB8J95B+s/mnbCZ+ZlXNgnOcMgkMhJfECr/N287es1oLV
 Vq6fHy78WiodjLMCu2Ofb0+mb8k2Z9XcOZCAjkFVvE6tbP6TsWGPVclvgLcZ1nUX5Q1H
 IEW77w7D1lzeS08M9SDNJQXpemrvFOrvud5CRyNBna6RgUPR4c9uQM7pzhgqNUKAqCTO
 M0Nr4TQMrCon9qLX3Cpw+RjNBzRoaaVqPKtWNZ7/o2cjBDKI2B036fDj66BiwDvKcz5z
 2Ws+9VzXGipsKFZxEHeWt1eHbvVvmX3vB9rxpd+MJ+NzaMDPhtWrMhsw9y70HZ+TWq9t
 lb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RCS+4Ey3rNNMXxja15cF4U80QWLQgMgI8w0IYpV4xJY=;
 b=pkrsZufXcuC/cJmjilSGjLLD8tOpoMgDiAzDGuEgMHt9+AzaV6ae8ew7wUUYtzEcbR
 e+G3lyqavoLsD4ULk680Vbc7yTrcUXudOP0rEi8yIco8cUGQV2XffsqfONSqqNf9qlCw
 wt9T4T93L0FxKpKqU/G5UjACmxB2ZaL+vdyw7vYvmT2TwLabq4ZxsqcvtLfs5Z5P6Sru
 SbhZ54Y2zG5uV/0BxmDm9fVxpqD/qA56ikBoHBo2yrgrOftqbZ7KkqPmOwtX8Gp1sv3h
 n38eXoW4rzdv0hgLj3jPuod35G6b4Jivd+tLEwqDOvxnA8PxLY6AGURFtd53YI9RmlbN
 /Ycg==
X-Gm-Message-State: APjAAAW7+0wB9YwmbKvTSN9oR5cB0lwgFilP8RK24M3z+urks7ExHI9e
 ZEW+VqQQLp55khRy7Ewbz6EjvQb24Z797PhxqxWbb1jd
X-Google-Smtp-Source: APXvYqwI8n+a3zlc4zADyL/x80UXXshpsd7TiGGPg13VS4jmWUBjvr6U8bnOHTNwRZf6nq89w6ZlKb8OuMXVG3Vznko=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr481230wrw.391.1575142968667; 
 Sat, 30 Nov 2019 11:42:48 -0800 (PST)
MIME-Version: 1.0
From: David Michael <fedora.dm0@gmail.com>
Date: Sat, 30 Nov 2019 14:42:37 -0500
Message-ID: <CAEvUa7=N7qUobof=vwpXF2XfXcW8R67SB3KV1phRN2ZmG23CvQ@mail.gmail.com>
Subject: Enhancement request: exclude paths from mkfs.erofs
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

I'd like to request support for excluding paths in mkfs.erofs similar
to the -ef (exclude file) option for mksquashfs.  An option that takes
a file containing a list of paths and glob patterns should be
sufficient.

For a simple use case:  I want to build an EROFS image from a Gentoo
install root, but I don't need development files in it.  An exclude
option would allow generating a smaller image without the unused files
while keeping them in the writable source path so additional packages
could be installed on it later.  This would have /usr/include and
/usr/lib/*.a for some basic entries in its exclude file.

If this isn't something that anyone else is interested in implementing
in the near future, I can try it myself and send a patch after I have
some time to get more familiar with the code.

Thanks.

David
