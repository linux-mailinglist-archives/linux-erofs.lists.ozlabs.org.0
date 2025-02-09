Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5829A2DEFE
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Feb 2025 17:07:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YrXfh0g2cz304l
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 03:07:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739117258;
	cv=none; b=kVL7gzkkTz2qRM376kKiYEzF0lbPRbQhw/wY7z+tIaS8d3SzNl68A+1NL2B1/DuReVUlaa5RlfdX7hiyYBDFXTnNZ1DLWfZ7os5jbXj5MnWCwZPUh2gzCFc0oJ6gwNSTgvsqhSUM/fNmqDLGcFYreN0Ur2wiOLUNuQ7mbIJ11vfvQ7NIcU4UdQQRHAcy82FmgPdnCZ1YvYAsJ4O/JneA4hT/S7uq9gRwnwIBbzzKwdLXi5dbkxdMKxY/OTZYCPsfAWL8k5+wPs8D9dlwKMt37poA2QPaZaR13aJ1dixl5ATRU3uf7NSHqlySUldDInGBSrx0sva56YooEBb70563Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739117258; c=relaxed/relaxed;
	bh=YmKtnQHKRholwFHa+YijHKNOUVC3AK/Ojbuy6b4kkqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QC92UeOTxyHfC+jSYw/Lm8Swl7yXeVgGi1D6EsLYEpvvXX4AqvBXdqzcdT22/3mgyy7B03VssdDKgEuunuer6Q4Qoul96HRLeTzpWJuFpV+/oCRHiQo0haDRnoTKAw+nEOP0lCi3XgN4DZDZsAAc/KhLOUi7aE+Rd4JVgbG1Mfchf02LJzq+TkDoo8VMQs1a+f4e6cpL2u2OSyzPVNl1A2w1tF58xjDaVBmBZjTrr2+PGbo82gdyi3cAOOZGG4o630QkYCgtYSxKC77fsj2sSjIPsHs8VvWjOTZkHnXVtbKCwn5XzBQtLh6QcKdNpfqOhUKFsM+eSTc8VUvi6vk5+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=joOc/hJ6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::12c; helo=mail-il1-x12c.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=joOc/hJ6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::12c; helo=mail-il1-x12c.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YrXfc6c20z2xrb
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 03:07:35 +1100 (AEDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so13628715ab.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Feb 2025 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739117253; x=1739722053; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmKtnQHKRholwFHa+YijHKNOUVC3AK/Ojbuy6b4kkqY=;
        b=joOc/hJ6HGQ0GtQ+7pFYV40JeVUS+mHjX1WgJaanNG5CZ0LzEohKFiWByk1uWl/hs+
         kmAW4CcuL8jTQk3T6ssMHs0G7rwhPRsDAFgliaqKWaV/fkZ/jPnxUcCj730PnQPyoFtB
         mHFw51Exqb1LHhTYNa43F0xZCckzCxJc3cuwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739117253; x=1739722053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmKtnQHKRholwFHa+YijHKNOUVC3AK/Ojbuy6b4kkqY=;
        b=C7HrUdNZgsdghx3jyWVorY2eDp/m+tDH0xQhrcg8g7Y/X+c+Ot01HsK73hf/iKYty2
         exB6Q1+1gg861svMhSjknicJygp0Nnuco+yvmkJ93x9jkncH0MggyQk9R2HbOaJV9P7T
         9sg6jn+jK50I1e4pSE1LUfNhAZGG5cOwYjzOs6XCPDsdYjeZodc1KLGrAdssRkXKFIO2
         HKNyULXJys3cFrH9fxvSKgBdhaShks+80VOLWGG2AvEHqXNBuudmZyZbM2hEV4FohJaW
         pVTX3Od5BprT7RZJiA0b22pDcdZ6QpBLrFffPmqjL8eokstAIRrlJTaxcXjv/kBxvC3/
         VU/g==
X-Forwarded-Encrypted: i=1; AJvYcCWVlXFq9jC7usvHTildSp7VTccWmlC6LhFyxov4JXUn/oBIzGIZm1dCOz8xt+tT3RBLhhSMIipG1nxhRQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YysnTIn47npFwywc76Ezgp1OETRbGZgjspwP5azFwQlXppfg0qZ
	5y2KV0iW7/2HyPuhT5a+BE3m8Gw0AnGC/DOt67sAHy3F8kmI9NFu4pLbZh51wA==
X-Gm-Gg: ASbGncuDbyt7jiZJ88YalRieb5bfBup1kBSorIjkQLS/xvD3sy6d4X2YzYRMf/gc1yf
	ikSA2s76/u4PaciTkmXy+g7xTMHn98uz30eiGOkMAh298V0HEPhMNCDxfl7mKepPjHMPFaKkaUV
	Ga6OfOvQ5ZWrQ9uX3P8xWAdVbKJSzpolcavG+WDVHSRuq6r7ZO+scFWJ2NHrpjKcqYApKBD+vYN
	FOAsCkvA/kMwe/u9s4n8kahALKQvojQ8Myea92Rkh2fzo4Psjbd6EJ8YAMhaYE36YFuPfS8yjdI
	ch3HNe71FbF/WZzh+A0V6C23Nqr9Po7inLkf6ZcNcCC0vBKyXBAy
X-Google-Smtp-Source: AGHT+IG3WOLuUmqaJl4Dj7D8rhctPByaR/qlOW1MhO5fhmcUrHAa6o6oERw+alIUyc5RPI+em+Y4Kg==
X-Received: by 2002:a05:6e02:1a23:b0:3d0:10ec:cc36 with SMTP id e9e14a558f8ab-3d13dd3bce4mr67029865ab.11.1739117253370;
        Sun, 09 Feb 2025 08:07:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net. [73.203.119.151])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 08:07:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH v2 0/6] test: A few quality-of-life improvements
Date: Sun,  9 Feb 2025 09:07:13 -0700
Message-ID: <20250209160725.1054845-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

Changes in v2:
- Use 'ubman' instead
- Add new patch to drop importing utils as util
- Add new patch to drop assigning ubman to cons

Simon Glass (6):
  test/py: Shorten u_boot_console
  test/py: Drop u_boot_ prefix on test files
  test/py: Drop importing utils as util
  test/py: Drop assigning ubman to cons
  test/py: Show info about module-loading
  test: Make net tests depend on CONFIG_CMD_NET

 doc/develop/py_testing.rst                    |  16 +-
 doc/develop/tests_writing.rst                 |  12 +-
 test/py/conftest.py                           |  89 +++---
 ...u_boot_console_base.py => console_base.py} |   8 +-
 ...onsole_exec_attach.py => console_board.py} |   6 +-
 ..._console_sandbox.py => console_sandbox.py} |   8 +-
 test/py/{u_boot_spawn.py => spawn.py}         |   0
 test/py/tests/fit_util.py                     |  42 +--
 test/py/tests/test_000_version.py             |   8 +-
 test/py/tests/test_android/test_ab.py         |  48 +--
 test/py/tests/test_android/test_abootimg.py   | 133 +++++----
 test/py/tests/test_android/test_avb.py        |  49 ++-
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
 test/py/tests/test_efi_fit.py                 |  93 +++---
 test/py/tests/test_efi_loader.py              |  84 +++---
 .../py/tests/test_efi_secboot/test_authvar.py | 120 ++++----
 test/py/tests/test_efi_secboot/test_signed.py | 148 ++++-----
 .../test_efi_secboot/test_signed_intca.py     |  46 +--
 .../tests/test_efi_secboot/test_unsigned.py   |  42 +--
 test/py/tests/test_efi_selftest.py            | 180 +++++------
 .../py/tests/test_eficonfig/test_eficonfig.py | 106 +++----
 test/py/tests/test_env.py                     |  82 +++--
 test/py/tests/test_event_dump.py              |   9 +-
 test/py/tests/test_extension.py               |  32 +-
 test/py/tests/test_fit.py                     |  67 +++--
 test/py/tests/test_fit_auto_signed.py         |  35 ++-
 test/py/tests/test_fit_ecdsa.py               |  31 +-
 test/py/tests/test_fit_hashes.py              |  29 +-
 test/py/tests/test_fpga.py                    | 280 +++++++++---------
 test/py/tests/test_fs/conftest.py             |   1 -
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
 test/py/tests/test_handoff.py                 |   5 +-
 test/py/tests/test_help.py                    |  28 +-
 test/py/tests/test_i2c.py                     |  44 +--
 test/py/tests/test_kconfig.py                 |  16 +-
 test/py/tests/test_log.py                     |  20 +-
 test/py/tests/test_lsblk.py                   |   4 +-
 test/py/tests/test_md.py                      |  22 +-
 test/py/tests/test_mdio.py                    |  32 +-
 test/py/tests/test_memtest.py                 |  26 +-
 test/py/tests/test_mii.py                     |  50 ++--
 test/py/tests/test_mmc.py                     | 156 +++++-----
 test/py/tests/test_mmc_rd.py                  |  54 ++--
 test/py/tests/test_mmc_wr.py                  |  20 +-
 test/py/tests/test_net.py                     | 142 ++++-----
 test/py/tests/test_net_boot.py                | 144 ++++-----
 test/py/tests/test_of_migrate.py              |  43 ++-
 test/py/tests/test_ofplatdata.py              |  11 +-
 test/py/tests/test_optee_rpmb.py              |  10 +-
 test/py/tests/test_part.py                    |   4 +-
 test/py/tests/test_pinmux.py                  |  32 +-
 test/py/tests/test_pstore.py                  |  48 +--
 test/py/tests/test_qfw.py                     |   8 +-
 test/py/tests/test_reset.py                   |  24 +-
 test/py/tests/test_sandbox_exit.py            |  28 +-
 test/py/tests/test_sandbox_opts.py            |  16 +-
 test/py/tests/test_saveenv.py                 |  70 ++---
 test/py/tests/test_scp03.py                   |   8 +-
 test/py/tests/test_scsi.py                    |  48 +--
 test/py/tests/test_semihosting/test_hostfs.py |  14 +-
 test/py/tests/test_sf.py                      |  66 ++---
 test/py/tests/test_shell_basics.py            |  30 +-
 test/py/tests/test_sleep.py                   |  26 +-
 test/py/tests/test_smbios.py                  |  12 +-
 test/py/tests/test_source.py                  |  45 ++-
 test/py/tests/test_spi.py                     | 242 +++++++--------
 test/py/tests/test_spl.py                     |  15 +-
 test/py/tests/test_stackprotector.py          |   8 +-
 test/py/tests/test_suite.py                   |  68 ++---
 test/py/tests/test_tpm2.py                    | 194 ++++++------
 test/py/tests/test_trace.py                   |  69 +++--
 test/py/tests/test_ums.py                     |  48 +--
 test/py/tests/test_unknown_cmd.py             |   6 +-
 test/py/tests/test_upl.py                     |  15 +-
 test/py/tests/test_usb.py                     | 206 ++++++-------
 test/py/tests/test_ut.py                      | 224 +++++++-------
 test/py/tests/test_vbe.py                     |  17 +-
 test/py/tests/test_vbe_vpl.py                 |  33 +--
 test/py/tests/test_vboot.py                   | 188 ++++++------
 test/py/tests/test_vpl.py                     |  11 +-
 test/py/tests/test_xxd/test_xxd.py            |   6 +-
 test/py/tests/test_zynq_secure.py             |  96 +++---
 test/py/tests/test_zynqmp_rpu.py              | 106 +++----
 test/py/tests/test_zynqmp_secure.py           |  42 +--
 test/py/{u_boot_utils.py => utils.py}         |  44 +--
 108 files changed, 3180 insertions(+), 3196 deletions(-)
 rename test/py/{u_boot_console_base.py => console_base.py} (99%)
 rename test/py/{u_boot_console_exec_attach.py => console_board.py} (95%)
 rename test/py/{u_boot_console_sandbox.py => console_sandbox.py} (93%)
 rename test/py/{u_boot_spawn.py => spawn.py} (100%)
 rename test/py/{u_boot_utils.py => utils.py} (89%)

-- 
2.43.0

