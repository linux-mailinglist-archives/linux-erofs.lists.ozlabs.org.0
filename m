Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01921A1C54D
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 22:32:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgSYz2yp1z2ywM
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 08:32:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::d29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737840725;
	cv=none; b=KL6pWS2rfoaP9h62rA9Blvv58oQcFh3xjajykfhu3TXa85kSgTfv2egyn0T2CZQn1/rOpLQxsCqujq6TgDJh2BYJ4YzkpdCex7fqtsnZByEz81LHOTPW+J1Bbsn3lMXSeRu5ZKVrG/EpNeEsh2HKIcPXUgyjzWrLvxEmiGMtlnqQ6OXwRpUdOs2hmce7slEMEs9ZxfEOF424lPAGvkEEgJGpmrKDD6Sckglo0JE9NCqOb/7VPDstqBgXM9Fn79FOY6P5T/FgH+ZMMZL4aOYKhiX4m8ppcgjIU+uzYZCq78S64gvsD2ZXJMBFOUv/FhvUKhVkXxO120dLscPKlgTe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737840725; c=relaxed/relaxed;
	bh=Yf3pCEV9tCLtFdnGlAC8rzndkMCZW32M1Efyq/TNnW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mk+hQACuNs5OR8U/rSqk794IPKGI5SDmsr2tWNoqZ+Cb4h+uqBuvj3LdnxyR9O5UBtrF8mbuVSSdgglnbdpDVtVyXJk2M7M+d6lOMujEHkKLOoA+cxa6DmX07f5ygJjZl+WTocCcd62kZ3wg8nETXdWktdGF34zbAZKEzsnnuWkOmPrBGGU2Qo3CxrgtyKYcrPiLlaoHbVDl8D+OwZPVT0hpB/TzRjyVjSkaxEStUFgb83Q+ChdifNhBuQVeERhSTfJFH61F8NEFXvySY6X4jYExgEQzb6GFCXiH85YsIqyVRBAntrDquWnlfOI+5RaRjHAPvUGT7Le1haHKxs/MJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VBPcJtvU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::d29; helo=mail-io1-xd29.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VBPcJtvU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::d29; helo=mail-io1-xd29.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YgSYw1GJgz2xrC
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 08:32:02 +1100 (AEDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-844e12f702dso85661039f.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737840720; x=1738445520; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf3pCEV9tCLtFdnGlAC8rzndkMCZW32M1Efyq/TNnW4=;
        b=VBPcJtvUdpdC4uqyy7rqtXwDCtsH53SNqkEUhqdLu4JXabuaRIXo75tN3JycoMgTTT
         NXriJfFCtjJ6rp6TKX9ACt2fRyzCZ3AFnhyzVjI80ITUDFVEUIFIgcBoD8m+DU0lBOLE
         I85FQK7MBzVy1s6HPdFS77ibBeS2nXtnDlqD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737840720; x=1738445520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf3pCEV9tCLtFdnGlAC8rzndkMCZW32M1Efyq/TNnW4=;
        b=uC11Fk5KJa+u8t/8+LxQwHVZFdB+Z1bJXnFQpQRXd1fF1n0/wOu2amsjZDZC7gHWia
         b4qTSV/wPksAmxNPiP78F9H2LwmWGPruBVSq+c9LBKTW6S6BHIeOaKj7QdIFERo3op5X
         7LE0gJQBg8/+gL0PUvwDLKjXW1WbTe3jQJuMrFemjjpT7uPJOCeb3w6HOnzIXbF/lznw
         zbYMMb0j50+/3MpPsYnHSHo1EMhLJOyQOIETrkK8dzTBROx2ZuWfSVHayFLI+KxmCxdd
         nX0Q6BnKmvU4pNyV6YA1JmApHGhlIgFSpTt81tuPdkGN9xbgc8uaedQB3bApHFRFo28m
         IV1w==
X-Forwarded-Encrypted: i=1; AJvYcCUGvpd6j4ejAHBoH4cxRpzmx9viv34yWJzWuYH6/1nlpxzR4/16GS/P+IamFG/YVdIzNJqJN+yu/p9kqQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpHJvJLJEZa/N6LsAq5WTGiZF+sH7DXyqAxF3YA8a38dX4TEzA
	L+IWjIQLPtNW3m5uXd3hYZCOI86dlbBSWzwWX2iS2xR95ZUPzX3a6cHhnIDdlQ==
X-Gm-Gg: ASbGnct9DZDFBvdRTk2A7LVyEzQnH7GdG/S9j8JNebtMVg9se6FnoYA8d/mu1zUMlHx
	QwJSl4ZyI2GktyphyN3FC7p51BQ6XRrC/j68J/a9xq2yp8g76JcqE+GvINP2f2duBgWFCtgViz/
	Jo30TNuusLtEaHI4cc4O25EhrzeKg/27fwj/1C+Dhq5BjiDs0p9RsI9Rdr7dlxnbNOeT/5lHs9K
	63FVh6JRz7hS/lmtSsgD21Rk32Rs07Ra5m7rRmLUzzMCe//hSNnHsPexO/MZssGrKxFK17aAdGG
	ftXR8nYRfest+/ikuQCM7YSKyGV+W4G6XiODuRn2Jw==
X-Google-Smtp-Source: AGHT+IG96iaY6rFI0mi9H3r777n+HmLXfkjEw+hfWKyir1wImjB1XM46lJ8BGD3n2nxr+bPkEo8FuA==
X-Received: by 2002:a05:6602:4186:b0:84f:5345:1800 with SMTP id ca18e2360f4ac-851b6165b7cmr2754707739f.2.1737840720072;
        Sat, 25 Jan 2025 13:32:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net. [73.203.119.151])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8521e01754dsm164103539f.32.2025.01.25.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 13:31:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH 0/4] test: A few quality-of-life improvements
Date: Sat, 25 Jan 2025 14:31:35 -0700
Message-ID: <20250125213150.1608395-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>, Joao Marcos Costa <jmcosta944@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Patrick Rudolph <patrick.rudolph@9elements.com>, William Zhang <william.zhang@broadcom.com>, Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@nvidia.com>, Sean Anderson <sean.anderson@seco.com>, Richard Weinberger <richard@nod.at>, Peter Robinson <pbrobinson@gmail.com>, Roger Knecht <rknecht@pm.me>, Julien Masson <jmasson@baylibre.com>, Weizhao Ouyang <o451686892@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tim Harvey <tharvey@gateworks.com>, Love Kumar <love.kumar@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, Michal Simek <michal.simek@amd.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-erofs@lists.ozlabs.org, Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This little series includes a few patches to make it easier to work with
the Python tests, by shortening identifiers and renaming the 'console'
fixture to reflect its role as the top-level fixture.

It also adds a command to fix testing on samus_tpl

This series is based on the previous 'test' series[1]

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=441124


Simon Glass (4):
  test/py: Shorten u_boot_console
  test: Drop u_boot_ prefix on test files
  test/py: Show info about module-loading
  test: Make net tests depend on CONFIG_CMD_NET

 doc/develop/py_testing.rst                    |  16 +-
 doc/develop/tests_writing.rst                 |  12 +-
 test/py/conftest.py                           |  89 +++---
 ...u_boot_console_base.py => console_base.py} |   8 +-
 ...onsole_exec_attach.py => console_board.py} |   6 +-
 ..._console_sandbox.py => console_sandbox.py} |   8 +-
 test/py/{u_boot_spawn.py => spawn.py}         |   0
 test/py/tests/fit_util.py                     |  12 +-
 test/py/tests/test_000_version.py             |   8 +-
 test/py/tests/test_android/test_ab.py         |  48 +--
 test/py/tests/test_android/test_abootimg.py   |  92 +++---
 test/py/tests/test_android/test_avb.py        |  50 ++--
 test/py/tests/test_bind.py                    |  72 ++---
 test/py/tests/test_bootmenu.py                |  46 +--
 test/py/tests/test_bootstage.py               |  18 +-
 test/py/tests/test_button.py                  |  16 +-
 test/py/tests/test_cat/test_cat.py            |   6 +-
 test/py/tests/test_dfu.py                     |  54 ++--
 test/py/tests/test_dm.py                      |  28 +-
 .../test_efi_bootmgr/test_efi_bootmgr.py      |  34 +--
 .../tests/test_efi_capsule/capsule_common.py  |  60 ++--
 .../test_capsule_firmware_fit.py              | 100 +++----
 .../test_capsule_firmware_raw.py              | 126 ++++----
 .../test_capsule_firmware_signed_fit.py       | 104 +++----
 .../test_capsule_firmware_signed_raw.py       | 104 +++----
 test/py/tests/test_efi_fit.py                 |   6 +-
 test/py/tests/test_efi_loader.py              |  84 +++---
 .../py/tests/test_efi_secboot/test_authvar.py | 120 ++++----
 test/py/tests/test_efi_secboot/test_signed.py | 148 ++++-----
 .../test_efi_secboot/test_signed_intca.py     |  46 +--
 .../tests/test_efi_secboot/test_unsigned.py   |  42 +--
 test/py/tests/test_efi_selftest.py            | 180 +++++------
 .../py/tests/test_eficonfig/test_eficonfig.py | 106 +++----
 test/py/tests/test_env.py                     |  78 ++---
 test/py/tests/test_event_dump.py              |   6 +-
 test/py/tests/test_extension.py               |  32 +-
 test/py/tests/test_fit.py                     |   6 +-
 test/py/tests/test_fit_auto_signed.py         |   6 +-
 test/py/tests/test_fit_ecdsa.py               |   6 +-
 test/py/tests/test_fit_hashes.py              |   6 +-
 test/py/tests/test_fpga.py                    | 280 +++++++++---------
 test/py/tests/test_fs/conftest.py             |   2 +-
 test/py/tests/test_fs/test_basic.py           | 104 +++----
 test/py/tests/test_fs/test_erofs.py           |  76 ++---
 test/py/tests/test_fs/test_ext.py             | 124 ++++----
 test/py/tests/test_fs/test_fs_cmd.py          |   4 +-
 test/py/tests/test_fs/test_fs_fat.py          |   6 +-
 test/py/tests/test_fs/test_mkdir.py           |  48 +--
 .../test_fs/test_squashfs/test_sqfs_load.py   |  54 ++--
 .../test_fs/test_squashfs/test_sqfs_ls.py     |  64 ++--
 test/py/tests/test_fs/test_symlink.py         |  46 +--
 test/py/tests/test_fs/test_unlink.py          |  50 ++--
 test/py/tests/test_gpio.py                    | 106 +++----
 test/py/tests/test_gpt.py                     | 178 +++++------
 test/py/tests/test_handoff.py                 |   4 +-
 test/py/tests/test_help.py                    |  18 +-
 test/py/tests/test_i2c.py                     |  44 +--
 test/py/tests/test_kconfig.py                 |  10 +-
 test/py/tests/test_log.py                     |  10 +-
 test/py/tests/test_lsblk.py                   |   4 +-
 test/py/tests/test_md.py                      |  22 +-
 test/py/tests/test_mdio.py                    |  32 +-
 test/py/tests/test_memtest.py                 |  26 +-
 test/py/tests/test_mii.py                     |  50 ++--
 test/py/tests/test_mmc.py                     | 148 ++++-----
 test/py/tests/test_mmc_rd.py                  |  54 ++--
 test/py/tests/test_mmc_wr.py                  |  20 +-
 test/py/tests/test_net.py                     | 142 ++++-----
 test/py/tests/test_net_boot.py                | 144 ++++-----
 test/py/tests/test_of_migrate.py              |  14 +-
 test/py/tests/test_ofplatdata.py              |   6 +-
 test/py/tests/test_optee_rpmb.py              |  10 +-
 test/py/tests/test_part.py                    |   4 +-
 test/py/tests/test_pinmux.py                  |  32 +-
 test/py/tests/test_pstore.py                  |  48 +--
 test/py/tests/test_qfw.py                     |   8 +-
 test/py/tests/test_reset.py                   |  24 +-
 test/py/tests/test_sandbox_exit.py            |  28 +-
 test/py/tests/test_sandbox_opts.py            |  10 +-
 test/py/tests/test_saveenv.py                 |  70 ++---
 test/py/tests/test_scp03.py                   |   8 +-
 test/py/tests/test_scsi.py                    |  48 +--
 test/py/tests/test_semihosting/test_hostfs.py |  14 +-
 test/py/tests/test_sf.py                      |  66 ++---
 test/py/tests/test_shell_basics.py            |  30 +-
 test/py/tests/test_sleep.py                   |  26 +-
 test/py/tests/test_smbios.py                  |  12 +-
 test/py/tests/test_source.py                  |   6 +-
 test/py/tests/test_spi.py                     | 242 +++++++--------
 test/py/tests/test_spl.py                     |  12 +-
 test/py/tests/test_stackprotector.py          |   8 +-
 test/py/tests/test_tpm2.py                    | 190 ++++++------
 test/py/tests/test_trace.py                   |   6 +-
 test/py/tests/test_ums.py                     |  48 +--
 test/py/tests/test_unknown_cmd.py             |   6 +-
 test/py/tests/test_upl.py                     |   6 +-
 test/py/tests/test_usb.py                     | 206 ++++++-------
 test/py/tests/test_ut.py                      | 128 ++++----
 test/py/tests/test_vbe.py                     |   4 +-
 test/py/tests/test_vbe_vpl.py                 |  14 +-
 test/py/tests/test_vboot.py                   |  12 +-
 test/py/tests/test_vpl.py                     |   8 +-
 test/py/tests/test_xxd/test_xxd.py            |   6 +-
 test/py/tests/test_zynq_secure.py             |  96 +++---
 test/py/tests/test_zynqmp_rpu.py              | 106 +++----
 test/py/tests/test_zynqmp_secure.py           |  42 +--
 test/py/{u_boot_utils.py => utils.py}         |  44 +--
 107 files changed, 2758 insertions(+), 2749 deletions(-)
 rename test/py/{u_boot_console_base.py => console_base.py} (99%)
 rename test/py/{u_boot_console_exec_attach.py => console_board.py} (95%)
 rename test/py/{u_boot_console_sandbox.py => console_sandbox.py} (93%)
 rename test/py/{u_boot_spawn.py => spawn.py} (100%)
 rename test/py/{u_boot_utils.py => utils.py} (89%)

-- 
2.43.0

