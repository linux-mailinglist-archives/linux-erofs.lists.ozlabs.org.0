Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0C38283BD
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 11:13:12 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J0lzM1uP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8RZs5vFYz30gL
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 21:13:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J0lzM1uP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=daan.j.demeyer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8RZn07WCz30Jy
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 21:13:03 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a28bd9ca247so276908266b.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jan 2024 02:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704795180; x=1705399980; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/H78gdlc/Sxp5KlVsRYMb82NODALvthr84xbxisXcQ=;
        b=J0lzM1uP4Xmj3uM1KEh/xQgvju/E5Ovj2zGxBfmYdRsy/aoKQBqCXTBZ8e4CVUcI4m
         Mp+j2wzSCT+AqqsK6T1qO736Uoo3xi55p9odU2wttd5TL0hEjTxQztYm03IEm1MS7O7o
         8jDjSTAL4rUDxihTPqKU+O1mWEdjwgek+VIzFu/u2WkUNatimLq0XQ7yPk5f0hY7mI3v
         TXf3Lt4NjC9f09cSqP576MGL2DeIq/r2aupNd/k0w0QgpDQt2YA/K32Rq06y++/Flnew
         A75JIQDg3kURFRNturWQb3VZuNNB3xGoPnyPSkGS5fzMLbpn6APqbtkRhNXmqVXYwfVK
         cwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704795180; x=1705399980;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/H78gdlc/Sxp5KlVsRYMb82NODALvthr84xbxisXcQ=;
        b=eBfOjNu07WT6hqLiSBT2VUanhQESMoj4RGwWa910kufFhVkvJvZVroWsmUSCL22mGV
         mvmvU/AhCZPRAIfp5IJM2xVSJZm1BDtvHFJTjwIl8NhgqqP9XRgtOjDnFKX5qPUcP39M
         iPsC0q5/yBN1Z9aYFB2vFdPK8zR1ah2dFLQVWR1n2HWIdYw5d1LwqljVMYJ5yGYiYwDb
         EgV58wj7iCuTz993b1YpRIU6g4UouwJJbzTI00b0DeR06OdruIQUycEQdz0O+6OjeDGu
         zKLXPLc+S1GVqOqUi4uDPNaMoIvYNU5FvuCCvCcs2KnzHKf/Z+Qo3oj99jDfKENcY/34
         kgSw==
X-Gm-Message-State: AOJu0YzkhZEgIVplTwuF4YCjWYExrrT9oqt8vYLsYHjSrJD9ls/IiE4g
	hHXjygRDItDgHtgG0HTMyZXNAy8snNIQu7gZKSfY62FWwcs=
X-Google-Smtp-Source: AGHT+IGW39e9mvkJCVTdB2c0S+JCpWUIwvmrjRUT3NgyRM2hdPYkw/ZtHO/8hvWZ7+XxUQlLs2mcBjDWFuwX9JjyDoM=
X-Received: by 2002:a17:906:fa1b:b0:a27:14c1:c106 with SMTP id
 lo27-20020a170906fa1b00b00a2714c1c106mr376468ejb.119.1704795179698; Tue, 09
 Jan 2024 02:12:59 -0800 (PST)
MIME-Version: 1.0
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Tue, 9 Jan 2024 11:12:48 +0100
Message-ID: <CAO8sHcmnq+foWo7AZYbkxJXHfSeZkd73Dq+1dQSZYBE6QxL8JQ@mail.gmail.com>
Subject: mkfs.erofs is noisy when run with a pipe attached to stdout/stderr
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

When executed with a pipe attached to stdout/stderr (for example in
CI), mkfs.erofs is super verbose as \r doesn't go to the beginning of
the line so mkfs.erofs will print a separate line for each file in the
root directory that is passed to mkfs.erofs. Could mkfs.erofs be
updated to not print a separate line for each file when stdout/stderr
are not ttys?

Cheers,

Daan De Meyer
