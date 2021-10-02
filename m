Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECDA41FE90
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 00:51:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HMMf00Q9Cz2yNY
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 09:51:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SyC2HGu5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f30;
 helo=mail-qv1-xf30.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=SyC2HGu5; dkim-atps=neutral
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HMMdx1rLpz2yHt
 for <linux-erofs@lists.ozlabs.org>; Sun,  3 Oct 2021 09:51:00 +1100 (AEDT)
Received: by mail-qv1-xf30.google.com with SMTP id o13so2087162qvm.4
 for <linux-erofs@lists.ozlabs.org>; Sat, 02 Oct 2021 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version;
 bh=xcJrrGWDbdJwOSoRknAYWyFbA2y63Ll+oilD762j6MY=;
 b=SyC2HGu59eWx1aRJRtwINM5ikkq/se6l9QJZ4N6Dvj2f4tPI4Oz/FgFtbQmN+A4lNE
 Pa/eOBOSN4Y1B67i5ZTmF7HcSDjy8FOvUejiZPiZpcsQ60PpKcQZTn0ZMnnXAm9odJO0
 VfepENBcDzzvZpQvdnJOP269vuFieXyyQwfU7mWu5ouI9e3wYhfnhGSQHcTtJxlUlWN0
 96iwBmSUToVjW1QKgXYc5m2IVwzbnanPaS2ebPlNXOx99AxbmGZ0oyNV1XdMcudcaiXO
 ESATU9zv1wWEVb0C39CkNUcuwrth5UFzmJQRlTu/J/ocZGpEvuYmkPpipSR7QE5Gw9ov
 2pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
 bh=xcJrrGWDbdJwOSoRknAYWyFbA2y63Ll+oilD762j6MY=;
 b=gDb2Wo+mNG+13LZMdqVYq/SVpjQrOo0QULecrxdoilv9X5TkX5IDXxgPiW7bzegxLj
 DG951aV1Zo0d4FYMPMqdGbPn3BfDPY1OQ7+ybR0rkzlrt1B1Hzt4iNzaDdABJJU4OwjR
 nVgPkhOhG73MUv6z9HmNAvZcv/Z4Sszdb8FjpFx7zrKAEtvya48o2YSdn78NNqv/Z/KU
 BixG6/UGx9PAlWEru5jkmz2F54PA2kJLATwgosgWEWYolUbuDLzi5d0UXinxCvuzERgh
 FuRj+u56RTIAOB6bbA98Vfx91fgpdGFTHS7YoRXLMRJw4RNk8deAkjpGpYJhioRLmJaF
 ksjg==
X-Gm-Message-State: AOAM533d2z4/1DwZnMCVgFILeHi0o2ezMRo8hrxOIa/pLlkqzYLBYIJt
 LJM5iK89nb3tp97zRIvQ9tYZ80gXjec=
X-Google-Smtp-Source: ABdhPJw7dJy3hNtaTpbbNOaFs3Wpa5OwBS883GiDBdXQ6iOrpTC6aVt0AaoYjYM040hIh8kFz6RAWg==
X-Received: by 2002:a0c:8dc6:: with SMTP id u6mr9446538qvb.66.1633215056620;
 Sat, 02 Oct 2021 15:50:56 -0700 (PDT)
Received: from callisto (c-73-175-137-55.hsd1.pa.comcast.net. [73.175.137.55])
 by smtp.gmail.com with ESMTPSA id
 k19sm5642463qko.115.2021.10.02.15.50.55
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 15:50:56 -0700 (PDT)
From: David Michael <fedora.dm0@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: SELinux labels not defined
Date: Sat, 02 Oct 2021 18:50:55 -0400
Message-ID: <8735pjoxbk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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

I tried to make an SELinux-labeled EROFS image, and the image itself
seems to contain the labels from a hex dump, but the mounted files are
all unlabeled:

# ls -lZ xml
total 8
drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
# mkfs.erofs test.img xml
mkfs.erofs 1.3-g4e183568-dirty
	c_version:           [1.3-g4e183568-dirty]
	c_dbg_lvl:           [       2]
	c_dry_run:           [       0]
# mount -o X-mount.mkdir test.img test
# ls -lZ test
total 8
drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig

This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
the relevant config options:

CONFIG_EROFS_FS=m
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_ZIP=y

I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
it also has the same issue.  However, the earliest kernel in Fedora 33
(5.8.15-301.fc33.x86_64) has the correct labels when the image is
mounted.  Is there a problem in the file system driver, or do I need to
do something different for newer kernels?

Thanks.

David
