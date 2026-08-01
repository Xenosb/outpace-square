/****************************************************************************
**
** Copyright (C) 2022 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Design Studio Material Bundle.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
****************************************************************************/

import QtQuick
import QtQuick3D

PrincipledMaterial {
    id: asphalt

    objectName: "Asphalt"

    cullMode: Material.NoCulling

    occlusionMap: asphalt010_2K_Opacity
    roughnessMap: asphalt010_2K_Roughness
    normalMap: asphalt010_2K_NormalGL

    roughness: 1
    metalness: 0
    specularAmount: 1
    clearcoatAmount: 0

    baseColor: "#1a1a1a"

    Texture {
        id: asphalt010_2K_NormalGL

        source: "maps/asphalt_normal.png"

        mipFilter: Texture.Linear
        generateMipmaps: true

        tilingModeHorizontal: Texture.Repeat
        tilingModeVertical: Texture.Repeat

        scaleV: 20
        scaleU: 20
    }

    Texture {
        id: asphalt010_2K_Roughness

        source: "maps/asphalt_roughness.png"

        mipFilter: Texture.Linear
        generateMipmaps: true

        tilingModeHorizontal: Texture.Repeat
        tilingModeVertical: Texture.Repeat

        scaleV: 20
        scaleU: 20
    }

    Texture {
        id: asphalt010_2K_Opacity

        source: "maps/asphalt_opacity.png"

        mipFilter: Texture.Linear
        generateMipmaps: true

        tilingModeHorizontal: Texture.Repeat
        tilingModeVertical: Texture.Repeat

        scaleV: 20
        scaleU: 20
    }
}
