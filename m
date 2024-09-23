Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4C97F0AD
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 20:35:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCBW300hcz2yVV
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 04:35:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727116508;
	cv=none; b=b5LDsouBLCNdrnPhNyoI6xIDGdIgN8vw3NxaDZZPvbTzs11/341cjW0Kfyt4t53B/wmNhJnYRkum7eWS/w6HA2dmEB469wV/0Uh+cxASl2jG04aX8ClfGCtUKNOKbUAuo/MJEHEIYqwimV6kO6PTcAIHoHUMgK+d/JfBnl97Hw2c+leKzjktIooQRU+sj/edmpsxTAJCBcrMv3XykOSuIHwuckwnskRqvdKiBxeNBlqhUJgnid0r5CiDj8xgPtTDnYeLxesfMP+sksb02MVN2uE2hph720oyl+TaPHshG0w5PaM3lw//H+cUQ/Jf2AMQ7K857p5MXu1To8QXsIRzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727116508; c=relaxed/relaxed;
	bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Egxv/YpahWe36ukSvenSq3hvbD4JWQc3LbjHdaN3Fde5QyS5oGP5etOYS4JHXtQp90pgCuHVTFY1hUjdWIQxqiVZLFqnqmTUc0kNn4WYltGRcRXDCdi4dQQlZYR8OHyJmjlXD1NDwXHWPHB/B29aE7srzuQxpU2cuO/kTotSK31mcCHpldAOZsCej7N0NM9bz48UauDeiHUNQMfHDTQVgI75jCVxusrHI56R8LP5612hfA1GO1qZ/PGc1NR7trBK5WR3wqucm/OjGF3XRF7vUxfwUbNn+yaVFzbYJdEUoIOTl9YVLHCQb2KH4xIIrrHFe9IFl1nhpdsvvnTKPamWog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Eo8LYwZZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com; envelope-from=chantr4@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Eo8LYwZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com; envelope-from=chantr4@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCBVz30pJz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 04:35:07 +1000 (AEST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-713aebfe8b8so1106968a34.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727116501; x=1727721301; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
        b=Eo8LYwZZ15g3mqe9XUxsm3vSNAgRyzzcrbwp31EAAF4IY1Tet36po2VMCChhSU3IzO
         U+Ka96bpMAi/X7jtFUX3EQv7tm1uGc+Wz+RJ/gEDaBdJKx+6Bs/kH3a8ZYufMStwV87h
         GZQR4VTdqvSUvhcC5TSYrPE0KF49rdDQdbutFpLFbb3LeSKEfv1xSVwsh6CQgcJSEtSy
         vTgSfpbQxvb60/qBoU+vbVK4Q6NO3N7gBlmvFWRrNbMwdxQc/SyfE7cvlyXicIxq7efI
         EYgOwkIx8ovox1J26MnRSc6we3fWrSAjJGcrLSrU15eJr53DlULl1sbo9idGePWgQCZA
         ynvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727116501; x=1727721301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
        b=XKRcNrnxG6keVab6l2E4A36vwB8wTx3PPhNwwkRCy+1LgS66eDEy6ztMusHkYs6Fcl
         TrUWa72gKQqslGmdm7C5nEBlsLu/a8dpWVCyM0tBdPLhM1PRlNONyQ/dG4YXP61kHYv0
         YsZndHIxK2EEK5GkljfF3M0B2rbXdSk04w0N3EO77FevppFEw23OxaMaeXXQVCZ5sqBC
         Ow77LzLBDUaxQqGXjuoMBVtud+6Xs9KuX27VptQRJAYD73QQzDgFktsqgpVlsxm7nZqv
         cepqcDMAAMRY/yvRNBbpAUrW9SfTVG7sB8Nye1G0iL4qJ64ziMOy1s1TAWEsNBg9Fiqo
         j5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUmjIQapM+xyQn54ug7wIFGs2IR9tFz5HE3sLnrxWM2Rage1Ei238+/VQMoKajWRhOma3QpT5tr5yHy3w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymXlKnBl/0Y/kiPG4Wpiofdv2Ux5poG9lH660dmUoloYAFoNyM
	O9CISQuiCbto5HBgOFhxdeyl/jfkzEHVRaBvTS55RHrmokf0jAs1
X-Google-Smtp-Source: AGHT+IFvgEYijirg/eXLBYiD5dxcd0Zmc+d70nalPrLG/FqXhYvz1aSQ8Ig7QbHNJjxjsN+QDuXf8g==
X-Received: by 2002:a05:6830:3891:b0:703:6076:a47 with SMTP id 46e09a7af769-71393533f16mr8751528a34.23.1727116501003;
        Mon, 23 Sep 2024 11:35:01 -0700 (PDT)
Received: from localhost (fwdproxy-vll-115.fbsv.net. [2a03:2880:12ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0d94409sm3611397eaf.18.2024.09.23.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:34:59 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: dhowells@redhat.com
Subject: [PATCH v2 19/25] netfs: Speed up buffered reading
Date: Mon, 23 Sep 2024 11:34:32 -0700
Message-ID: <20240923183432.1876750-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240814203850.2240469-20-dhowells@redhat.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, eddyz87@gmail.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,


It seems this commit (ee4cdf7ba857: "netfs: Speed up buffered reading") broke
booting vms using qemu. It still reproduces on top of linux-master.

BPF CI has failed to boot kernels with the following trace [0]. Bisect narrowed
it down to this commit.
Reverting ee4cdf7ba857 on to of current bpf-next master with [1] (basically
ee4cdf7ba857 where I had to manually edit some conflict to the best of my
uneducated knowledge) gets qemu boot back on track.

This can be reproed by following the build steps in [2]. Assuming danobi/vmtest
[3] is already installed, here is the script used during bisect.

  #!/bin/bash
  cat tools/testing/selftests/bpf/config{,.$(uname -m),.vm} > .config
  make olddefconfig
  make -j$((4* $(nproc))) || exit 125
  timeout 10 vmtest -k $(make -s image_name) "echo yeah"
  exit $?

The qemu command invoked by vmtest is:

qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio" \
  "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=on,wait=off" \
  "-chardev" "socket,path=/tmp/qga-888301.sock,server=on,wait=off,id=qga0" \
  "-device" "virtio-serial" \
  "-device" "virtserialport,chardev=qga0,name=org.qemu.guest_agent.0" \
  "--device" "virtio-serial" \
  "-chardev" "socket,path=/tmp/cmdout-508724.sock,server=on,wait=off,id=cmdout" \
  "--device" "virtserialport,chardev=cmdout,name=org.qemu.virtio_serial.0" \
  "-virtfs" "local,id=root,path=/,mount_tag=/dev/root,security_model=none,multidevs=remap" \
  "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
  "-no-reboot" "-append" "rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-init4PdCA.sh panic=-1" \
  "-virtfs" "local,id=shared,path=/data/users/chantra/linux,mount_tag=vmtest-shared,security_model=none,multidevs=remap" \
  "-smp" "2" "-m" "4G"


[0] https://gist.github.com/chantra/683d9d085c28b7971bbc6f76652c22f3
[1] https://gist.github.com/chantra/642868407d10626fd44febdfed0a4fce
[2] https://chantra.github.io/bpfcitools/bpf-local-development.html#building-a-vm-friendly-kernel-for-bpf
[3] https://github.com/danobi/vmtest
