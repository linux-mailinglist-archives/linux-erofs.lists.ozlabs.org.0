Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081C99AD72
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 22:23:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XQJ3H6JpKz3c3s
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 07:23:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728678185;
	cv=none; b=LzTDUyxPcW8COBGpRi8bpqsal+H3Uu963V+wWYjLr+s/8epVAZJfNCqm2FqrXA1GuekdOaQd8833NSgQib+2b8yjfta5Va4sGNU6TNd1OkQOtBepcIlmGcdBtMIZSLnUDwaVwxPt46rtvsRdCwhQB8rJefYn4Zw0m36YZQNu+b682zNKTQtdYcyXRDNKGqjiBcw4DNHTTN4/6UlVjrp/m7V4wG3IM9ME0vgKTD0LXtH+pmOqchYAxlq1z7IEwDPSqi/RXtC4Upf9shUgwQ1ELYyi9XKd1qAZROAXHM13rTpnH7Y8PHxWXhzK8W1G7yA6bjxHyHpKUZpGgNaQtg+cRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728678185; c=relaxed/relaxed;
	bh=P6CMN2nKdeDn7O0ThHc63pN7dVVQ09yscr9ayrYwxzI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TXfpcnM46abHdYIu+QH9rsMFPI45DUGsfG/aG6e7IGtrZCXNTzuNdKiNbdF922I/iWs9S36OQICA3kCA+Za0qYbl5DuNzdDc1bddBTjWpKYs/gv3dJdYHXmTNjkVgWVIYJdqVqk7fAMeYGAhng5tdNlrom5Jx8BL4v7cBOejBSFfb1p1WFFoB/wPpnCPqYlKdXFlrlhJwJZttDYIKH2vLR7MpeltYvHVXX3la1PyeLLM5DfuwAx2XBY0xsqIBbLHenUuhBw1YpebgV82/RMqf5oh6LOJuXMPdFilzCWltBGPqNAEzq/oBvTcS+3aQN9Lx5qUntvDScL7JMHwGzOqeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Uzw7ew5j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b32; helo=mail-yb1-xb32.google.com; envelope-from=fedora.dm0@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Uzw7ew5j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b32; helo=mail-yb1-xb32.google.com; envelope-from=fedora.dm0@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XQJ3C62f0z2xjY
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2024 07:23:03 +1100 (AEDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-e290554afb4so2538067276.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728678180; x=1729282980; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6CMN2nKdeDn7O0ThHc63pN7dVVQ09yscr9ayrYwxzI=;
        b=Uzw7ew5jWpc2/6LWrQf1sB9LCIKyLt+Ts2DH14URbgfax8F8CZ8lKh5nK7XOI/DwTT
         TMj2nEudeO5oOg2Vt7tcNWVkJjtSZJmH/u6x5o/jPqzRU3csp0Bs1ehpleI+sQP9dY0e
         HZ6dMUONTH2/6tLADhicBc7mUz5V7xAj3vVn3XYuLqC/aLtaXS+b76Kv65mhu0lYwx0V
         ZQTvHZcS6EQHUiNSKDNseAv5dsHNBY7IaaflGU2jcf9XPM0KUJLsZrD2WSFW/rd8oHw0
         FhC1ivzjn2EiKOcdg+UNi3OmXBTVZQUswPQm8ZNgExo1eHt5ybt3z3LnncrygR2GbgpL
         iEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728678180; x=1729282980;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6CMN2nKdeDn7O0ThHc63pN7dVVQ09yscr9ayrYwxzI=;
        b=khEOC1lV1kpfmjyYGkQ19rVhhy2xi3xe/2QG3NMDmo5/ObCw2yQpb/ebV08PL7R+Rs
         Ilu9oHtm1bQ89E0dFyl0arKcYqLZkkxJDgHgJtd+lPoAZTKZMLmR/0xKFfIZpN1f4HFC
         Xv27zFG1IYj2vgQqshNDwqFtDjARmxvH3L0u4pnhD/uDx7NL7/QQEELDJuRTFXT+CGYP
         r2c5a0wrMG20ktr4GB7BuNXW45dWarSc64XHdZJdAJk1mqua54oRDSF5+IfV4avfvSlu
         KMRcvaVdyYelscb00DnxyoEzApbfnd8Q+zcqceVQxaTqo4zF7s7vf79DlDZySnwOxDs7
         MVHw==
X-Gm-Message-State: AOJu0YwIb+AZ+Frrw12GgoOorHjSl2I1veoDo7lLOKFv91elGnrrmXVZ
	bbuz0kE2obuPEi8mu7sBScAQfGQNYYTSjnM64ojSehseV33flHK52VSxfTyeUD3WruyqbWrmvjF
	a8gxfMycXy6rLxtAAsRCGLDhbsI7f1lFP
X-Google-Smtp-Source: AGHT+IFlNA+dSwjbx2knDL/hpt/fzxLDr8WkduHQ6HjjXAnyMSkdydOCEs3agCj8UPjDBXUiOTYrT5Cbpb9svEfD3NI=
X-Received: by 2002:a05:6902:1611:b0:e28:ec85:904b with SMTP id
 3f1490d57ef6-e2919d678c9mr4181542276.8.1728678179864; Fri, 11 Oct 2024
 13:22:59 -0700 (PDT)
MIME-Version: 1.0
From: David Michael <fedora.dm0@gmail.com>
Date: Fri, 11 Oct 2024 16:22:49 -0400
Message-ID: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
Subject: [bug report] erofs-utils: Compression with -Eall-fragments segfaults
 on 1.8.2
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

Version 1.8.2 has a reproducible segfault with "-E all-fragments"
(testing on Fedora 40).  When compressing the install image, it
consistently hangs on a firmware file:

> sudo dnf -y install erofs-utils
> wget https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/images/install.img
> sudo mount install.img /mnt
> sudo mkfs.erofs -z zstd -E all-fragments erofs.img /mnt

If you isolate just that firmware directory instead of the whole
image, it will segfault:

> mkfs.erofs -z zstd -E all-fragments erofs.img /mnt/usr/lib/firmware/nvidia/ga102/gsp

It happens with all compressors I've tried, but adding "dedupe" works
around it.  Is there any change I should test?  Let me know if you
need additional information.

Thanks.

David

Originally reported in: https://bugzilla.redhat.com/2318138
