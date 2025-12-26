Return-Path: <linux-erofs+bounces-1617-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E15CDEB43
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 13:36:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dd4qB6BgBz2yFQ;
	Fri, 26 Dec 2025 23:36:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766752582;
	cv=none; b=nlGGpkw/sOo/Zs2LZ3WWNlYrOdq1AaE5uNjHBqRkmwMuzZr+El6pFjpMbY3F4+kb3o7/sZFz480x5AXLCBpdEuCVMxPvOIZYUkj0Kz8ZCHrW+qHHqlsWJaLH8ifPgJlWUwZ+Bp3T26kJSG0bz74H5QiB1HHZpUQFglUVcESJykR8YQRirdD8umdgkOV+G3ogJKgqXFN09PADhGo/pLHcNcGWxsO/BmgB7mEccrz3zALNlyxztKkt/E+X8rwm1+iI3OS6GkAnI5VvKI3WK2IYm0yNxG5dmSciZJnBZUMY8ALZn3oVRC7qD3UNI4H87iTs5EFg030/6mBa0lzUg6KYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766752582; c=relaxed/relaxed;
	bh=V6tRdcuP0wqKPHELS2CPAX3klPxKMBxEEEHLvH3w9ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lBl69HQ4EPMfnX/R+XvaClUp7yh4oySM5N6vK+Ye9kJdcmxe/kxwgcTU/YoHAXC5AGdxRbsVWwfIG2OpoxAipCRJdNZ32ZCnsMgWDMRPQWzqpvSWqiW0v5PaVqb9/pM6HiSNUEdGb8PSKqsjUpvReE+VDGZqfVe5YHs6IRO0VggHoQhv9DIxiZN1xCh5tgnMYnJ6vZPfIyD9dQvUQZ5tlx93277KzbN55FuabRGApSTmZVkCyj64fVtPtHmAtuuOhCLofWS26Hedc1VHOoCfRaPAS8VS2QgOG36Wj+szJuQgP8mAExCIQkpvzWFHiBPp4sijGje7JavNgpo3WpOupw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=digitaltide.io; dkim=pass (2048-bit key; unprotected) header.d=itoolabs-com.20230601.gappssmtp.com header.i=@itoolabs-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=tWeOCQoY; dkim-atps=neutral; spf=pass (client-ip=209.85.128.53; helo=mail-wm1-f53.google.com; envelope-from=alexey.naidyonov@itoolabs.com; receiver=lists.ozlabs.org) smtp.mailfrom=itoolabs.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=digitaltide.io
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=itoolabs-com.20230601.gappssmtp.com header.i=@itoolabs-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=tWeOCQoY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=itoolabs.com (client-ip=209.85.128.53; helo=mail-wm1-f53.google.com; envelope-from=alexey.naidyonov@itoolabs.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dd4q93KlPz2xlM
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 23:36:20 +1100 (AEDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso38899685e9.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itoolabs-com.20230601.gappssmtp.com; s=20230601; t=1766752517; x=1767357317; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6tRdcuP0wqKPHELS2CPAX3klPxKMBxEEEHLvH3w9ao=;
        b=tWeOCQoYHVjK6aGIA+5txachC371dUcxf7BRdquEa14dtCXHVC8/y64B18spXRDCyF
         ZKwjRXRZ75SoD2RAwJ64uctS8TEk33otS1vRvD1sYjROkOwRXOtGNrIZWuIk52lDYysx
         WBVhdZHXyRH9j55sMC0nLdEluE2mtxxgLx7qpijk6H97EPygQXJ89cb6OuRaZh0cTSdt
         ZOpMajPsE/cGfLG1VrMS96HpdkX+Ajsl4IJ45+58cpIEdOy82Y9pon4tFwW2sbl+E+Fn
         cNhuIoST2tX3SrieDbY8KAbA1OE4EDQjBPVW8s7E8Vm5Kw4l0KKUmmG1DRY9/oPGcW/7
         tX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766752517; x=1767357317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6tRdcuP0wqKPHELS2CPAX3klPxKMBxEEEHLvH3w9ao=;
        b=HyCHoGw8i9yBhgvDsCU0xYtgF8lHi7P9gs5b9fC3XSviTqD7+gfY2KfpemIpjhpuKG
         77QUdZlGh6tXtRVtzXlEGZtSXVv6pfgaaUp4VUDU7WRpZkp7vtPTGAhAPZ03Z/0cP52Y
         bmvnCX6flfL+P+jRLnMXKn0BRpCmQvSzmEdYLyCMJljUSxF/VQdp8Xxn/va8AjvmV0xu
         5sw/rQUH1AmpnmfwQ1SVLhzPM3XXx+49JStcQV/faHo9SzphRw24obKd++YPjAaQ3d0b
         9C2BrzU98Zzw0sfBQrL4UsqyQ7bD1a6KRL+c5PzvYZqdfbIIo4se6XQC6BVrXs+NNprd
         i6iQ==
X-Gm-Message-State: AOJu0Yzx3g5GkM9TAhp4gbE130k5BWzNxD1ZKiB9CIFOe2qax+XLaZzx
	VONrCHw74BhzpzdwcWqGAYK6DLD9LYkvKoe44/YJ/dQlbtC6kuBGRkXDmQNNyaQHTvs=
X-Gm-Gg: AY/fxX40WSSnvd1SDHwyF4NrqlOSJoyyinyd9K2yW0ajFD7CqaE8mcVYUewsKvU4HH+
	BM6vPSSWZJ2t4xRwk7DkzzERVv6Td0w/2KBpE0zc6/PZB5OnZLY5DhGNIkxgoKq99Z6ItIfmg4E
	HH9xynBNZBF7TxnUg1g5gc4+Lm65hI8TM4ZfaQU4hmvBg+4dX1m0ZwIJd8kVCAD7Ls875nd+k2p
	J9Ss15JzJZCLyCNeDKeNTfCvBDsONCW8w6jl6apDS+tYUPxc8dS/5l0ehZ1qDtQNkhiwCJBFMBn
	0ZbRRq66CU7t6SxYS/cEg40VSoFhsc1tWVaCIQQoyrI7/Z7qpMZGKiswTyKpBdUqcUBpnIG5bj7
	wtoFV3JfZXscOsfqThAAVOIzW7vQupMn/4KPQXzh2fsti9RdikRgS7ytRqxKpTrdk5sKnLcbCxR
	po8W1Lt+I=
X-Google-Smtp-Source: AGHT+IGpcB6fzs67bzB42F3nEfa7jC6d98MoCdt0ERV86bPdMf/lMarUyr6A03ZLX3YHQkzarY7wEw==
X-Received: by 2002:a7b:c454:0:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47be29adacbmr184783165e9.7.1766752517546;
        Fri, 26 Dec 2025 04:35:17 -0800 (PST)
Received: from gamestation ([188.26.196.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm432931215e9.4.2025.12.26.04.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 04:35:17 -0800 (PST)
From: =?UTF-8?q?Aleks=C3=A9i=20Naid=C3=A9nov?= <an@digitaltide.io>
To: stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	xiang@kernel.org
Subject: [REGRESSION] erofs: new file-backed stacking limit breaks container overlay use case in 6.12.63
Date: Fri, 26 Dec 2025 13:34:37 +0100
Message-ID: <20251226123453.5914-1-an@digitaltide.io>
X-Mailer: git-send-email 2.51.2
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

I am reporting a regression in the 6.12 stable series related to EROFS file-backed mounts.

After updating from Linux 6.12.62 to 6.12.63, a previously working setup using OSTree-backed 
composefs mounts as Podman rootfs no longer works.

The regression appears to be caused by the following commit:

    34447aeedbaea8f9aad3da5b07030a1c0e124639 ("erofs: limit the level of fs stacking for file-backed mounts")
    (backport of upstream commit d53cd891f0e4311889349fff3a784dc552f814b9)

## Setup description

We use OSTree to materialize filesystem trees, which are mounted via composefs (EROFS + overlayfs) 
as a read-only filesystem. This mounted composefs tree is then used as a Podman rootfs, with 
Podman mounting a writable overlayfs on top for each container.

This setup worked correctly on Linux 6.12.62 and earlier.

In short, the stacking looks like:

  EROFS (file-backed)
    -> composefs (EROFS + overlayfs with ostree repo as datadir, read-only)
        -> Podman rootfs overlays (RW upperdir)

There is no recursive or self-stacking of EROFS.

## Working case (6.12.62)

The composefs mount exists and Podman can successfully start a container using it as rootfs.

Example composefs mount:

    ❯ mount | grep a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c
    a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c on /home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c type overlay (ro,noatime,lowerdir+=/proc/self/fd/10,datadir+=/proc/self/fd/7,redirect_dir=on,metacopy=on)

(lowedir is a handle for the erofs file-backed mount, datadir is a handle for the ostree 
repository objects directory)

Running Podman:

    ❯ podman run --rm -it --rootfs $HOME/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c:O bash -l
    root@d691e785bba3:/# uname -a
    Linux d691e785bba3 6.12.62 #1-NixOS SMP PREEMPT_DYNAMIC Fri Dec 12 17:37:22 UTC 2025 x86_64 GNU/Linux
    root@d691e785bba3:/# 

(succeed)

## Failing case (6.12.63)

After upgrading to 6.12.63, the same command fails when Podman tries to create the writable overlay 
on top of the composefs mount.

Error:

    ❯ podman run --rm -it --rootfs $HOME/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c:O bash -l    
    Error: rootfs-overlay: creating overlay failed "/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c" from native overlay: mount overlay:/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/merge, flags: 0x4, data: lowerdir=/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c,upperdir=/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/upper,workdir=/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/work,userxattr: invalid argument
    ❯ uname -a
    Linux ci-node-09 6.12.63 #1-NixOS SMP PREEMPT_DYNAMIC Thu Dec 18 12:55:23 UTC 2025 x86_64 GNU/Linux

## Expected behavior

Using a composefs (EROFS + overlayfs) read-only mount as the lowerdir for a container rootfs overlay 
should continue to work as it did in 6.12.62.

## Actual behavior

Overlayfs mounting fails with EINVAL when stacking on top of the composefs mount backed by EROFS.

## Notes

The setup does not involve recursive EROFS mounting or unbounded stacking depth. It appears the new stacking 
limit rejects this valid and previously supported container use case.

Please let me know if further details or testing would be helpful.

Thank you,
-- 
 Alekséi Nadénov



