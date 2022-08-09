Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBA58DD91
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 20:00:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M2LSj0783z306m
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Aug 2022 04:00:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hjh3tTr7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hjh3tTr7;
	dkim-atps=neutral
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M2LSY6wC5z2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Aug 2022 03:59:57 +1000 (AEST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3246910dac3so119342047b3.12
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Aug 2022 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=sqeWFUxt/Oz7Ci86UAOOZzXD/XhtDTP8vMidh9jzElE=;
        b=hjh3tTr7ibWnxRHQBIW9VSP95YxEZreuY7+0aImb3zRI51u8Kph/wgVo5+1YiXw088
         NLwhY0nsWkJcrXHrhAcqqTnohYZ8YlD3+RNzpE75M1kW9BE3RfbVxGxWx8wDANkFgJnj
         5ToJtozAjnLeCdUOzOGCF0mTdaZgy0Wz7SsH9BrIHZ7F+kK7OkCUIWo4/yQUYogAJY5s
         4r7mzviAbkB9f4L+8/Qo4GKlTPN5DHy1eMyT558D7oVp3bVwEaNmSQVIYcaWho0v+sO2
         FMrlQXLw1viO/LAe59xtyh2DuarThLnqf9Eyb8iWKFKETjixxAwWk/iK5MwQg0cwslBx
         Imzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=sqeWFUxt/Oz7Ci86UAOOZzXD/XhtDTP8vMidh9jzElE=;
        b=W+kPhKJ6+JmXoWk8vVq0iGAecBhnsOhHAtMdqygS4iWepkv2F57L3QG/J8YCi860d2
         I1ikw44Hb4FMxhV1K+0l26MxJ7Ht4bBkS91BTfE4pgR+32txF/naAPOK7sMjJ/U2QOeg
         L75H+2WnJLKcAjVvQlcVvxVAhiXd/HJ04QxKNLrX3phx/c7w5ZTZLPhqOnRkTAIZ5AIA
         4yDfOIc7fP+h6TpdWjc+OTzJ5nzHbIlltKnik7wbNReKvC+RcR03sc/M+CQQTCl3sqXi
         sFOqps50THQk3HqBUbxkSeXI7egrRBDpzRDAo2xkYwykhkuWThCwT80fXVq3rwP2wCUg
         rzgw==
X-Gm-Message-State: ACgBeo2ggs8jnoI7ZSEKbM1V+ZyuU1k58WZkxYzFU1LY8IO19seIqfAj
	+t31IWFy0qq7/ZWGFCHIsvCscIKMD0R9V7P82X4gv6tUlI4=
X-Google-Smtp-Source: AA6agR7QEGzrQVmQ6Jlw2Enh0tcxh3sfMjxrBNxzKzpxLjOcarPpePr0oZ2yNKk9VGSMqrMjmKTNEGquLb4vm1HY8po=
X-Received: by 2002:a81:b71c:0:b0:324:5feb:c4ef with SMTP id
 v28-20020a81b71c000000b003245febc4efmr24295941ywh.231.1660067993448; Tue, 09
 Aug 2022 10:59:53 -0700 (PDT)
MIME-Version: 1.0
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Wed, 10 Aug 2022 02:59:42 +0900
Message-ID: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
Subject: RFC: erofs-utils:mkfs: add unprivileged container use-case support
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

Hi all.

I investigate each read only filesystem for linux at linux container
use-case.  The erofs is most interesting filesystem.
A each files of guest root filesystem need to shift uid/gid in case of
unprivileged container to use uid/gid namespace.  I work adding
uid/gid offsetting support to erofs-utils mkfs tool now.
Will be this patch accept in upstream community?

Thanks,
Naoto Yamaguchi,
a member of Automotive Grade Linux Instrument Cluster EG.
